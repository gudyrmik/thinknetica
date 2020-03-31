# frozen_string_literal: true

require_relative 'vendor.rb'
require_relative 'instance_counter.rb'

# Abstract class for trains
class Train
  include Vendor
  include InstanceCounter

  attr_reader :serial_number, :type, :route

  @@obj_references = []

  def initialize(serial_number, type)
    @serial_number = serial_number
    @type = type.to_sym
    validate!
    @cars = []
    @speed = 0
    @@obj_references << self
    register_instance
  end

  def each_car
    # Так вы не на тот метод смотрели, то рудимент. Вот правильный:)
    @cars.each { |car| yield(car) }
  end

  def self.find(serial_number)
    @@obj_references.select { |train| train.serial_number == serial_number }
  end

  def accelerate(new_speed)
    @speed = new_speed
  end

  def stop
    @speed = 0
  end

  def add_car(car)
    @cars << car if speed.zero? && car.type == @type
  end

  def remove_car
    @cars.delete_at(-1)
  end

  def cars_number
    @cars.size
  end

  def assign_route(route)
    @route = route
    @route.source.accept_train(self)
  end

  def move_forward
    next_station = @route.stations[current_station_index + 1]
    unless next_station.nil?
      current_station.dispatch_train(self)
      next_station.accept_train(self)
    end
  end

  def move_backward
    prev_station = @route.stations[current_station_index - 1]
    unless prev_station.nil?
      current_station.dispatch_train(self)
      prev_station.accept_train(self)
    end
  end

  def to_s
    @serial_number.to_s + ', type: ' + type.to_s + ', cars: ' + cars_number.to_s + ', route: ' + @route.to_s
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  private

  # Для обоих полей есть кастомная гет/сет пара, дефолтный геттер нужен только для внутреннй логики
  attr_reader :speed, :cars

  SERIAL_REGEXP = /^[A-Za-z0-9]{3}-?[A-Za-z0-9]{2}$/.freeze

  def validate!
    validate_number
    validate_type
  end

  def validate_number
    raise 'Invalid serial number' if @serial_number !~ SERIAL_REGEXP || @serial_number.nil?
  end

  def validate_type
    raise 'Unknown train type' unless @type == :cargo || @type == :passenger
  end

  # Нужен только для методов движения
  def current_station
    @route.stations.find { |station| station.trains.include?(self) }
  end

  # Нужен только для методов движения
  def current_station_index
    @route.stations.index(current_station)
  end
end

# Class for passenger train objects
class PassengerTrain < Train
  include InstanceCounter

  def initialize(serial_number)
    super(serial_number, :passenger)
  end
end

# Class for cargo train objects
class CargoTrain < Train
  include InstanceCounter

  def initialize(serial_number)
    super(serial_number, :cargo)
  end
end
