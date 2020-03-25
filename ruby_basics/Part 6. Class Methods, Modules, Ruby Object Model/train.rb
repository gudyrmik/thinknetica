require_relative 'vendor.rb'
require_relative 'instance_counter.rb'

class Train
  include Vendor
  include InstanceCounter

  attr_reader :serial_number, :type, :route

  @@obj_references = []

  def self.find(serial_number)
    @@obj_references.select { |train| train.serial_number == serial_number}
  end
  
  def accelerate(new_speed)
    @speed = new_speed
  end
  
  def stop
    @speed = 0
  end
  
  def add_car(car)
    cars << car if speed == 0 and car.type == @type
  end
  
  def remove_car()
    cars.delete_at(-1)
  end

  def cars_number
    cars.length
  end
  
  def assign_route(route)
    @route = route
    @route.source.accept_train(self)
  end
  
  def move_forward
    next_station = @route.stations[get_current_station_index + 1]
    if next_station != nil
      get_current_station.dispatch_train(self)
      next_station.accept_train(self)
    end
  end
  
  def move_backward
    prev_station = @route.stations[get_current_station_index - 1]
    if prev_station != nil
      get_current_station.dispatch_train(self)
      prev_station.accept_train(self)
    end
  end

  def to_s
    @serial_number.to_s + ', type: ' + type.to_s + ', cars: ' + @cars_number.to_s + ', route: ' + @route.to_s
  end

  private
  # Для обоих полей есть кастомная гет/сет пара, дефолтный геттер нужен только для внутреннй логики
  attr_reader :speed, :cars

  # Нужен только для методов движения
  def get_current_station
    @route.stations.find { |station| station.trains.include?(self) }
  end

  # Нужен только для методов движения
  def get_current_station_index
    @route.stations.index(get_current_station)
  end

  # Конструктор для "абстрактного" класса поезда в паблике не нужен
  # API железной дороги работает с определенными типами поездов
  # (есть ли в Руби классические абстрактные классы?
  # ну у которых нет паблик-конструктора и которые нужны для наследования от них)
  def initialize(serial_number, type)
    @serial_number = serial_number
    @type = type
    @cars = []
    @cars_number = 0
    @speed = 0
    @@obj_references << self
    register_instance
  end
end

class PassengerTrain < Train
  include InstanceCounter

  @instances = 0

  def initialize(serial_number)
    super(serial_number, :passenger)
  end
end

class CargoTrain < Train
  include InstanceCounter

  @instances = 0

  def initialize(serial_number)
    super(serial_number, :cargo)
  end
end