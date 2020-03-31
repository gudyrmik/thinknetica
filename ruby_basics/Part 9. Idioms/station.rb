# frozen_string_literal: true

require_relative 'instance_counter.rb'

# Class for station objects
class Station
  include InstanceCounter

  attr_reader :title, :trains

  def initialize(title)
    @title = title
    validate!
    @trains = []
    @@obj_references << self
    register_instance
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def self.all
    @@obj_references
  end

  def trains_by_type(type)
    trains.select { |train| train.type == type }
  end

  # "У класса Station:
  # написать метод, который принимает блок и проходит по всем поездам на станции, передавая каждый поезд в блок."
  # Не уверен что правильно понимаю что требуется, но согласно описанию, вот:
  def each_train
    trains.each { |train| yield(train) }
  end

  def accept_train(train)
    @trains << train
  end

  def dispatch_train(train)
    @trains.delete(train)
  end

  def to_s
    str = @title.to_s
    @trains.each { |train| str += "\n #{train} " }
    str.chomp
  end

  private

  TITLE_REGEXP = /^[A-Z]{1}[a-z0-9]+$/.freeze

  def validate!
    validate_title
  end

  def validate_title
    raise 'Invalid station name' if @title !~ TITLE_REGEXP || @title.nil?
  end

  @@obj_references = []
end
