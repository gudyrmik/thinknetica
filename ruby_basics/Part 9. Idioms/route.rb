# frozen_string_literal: true

require_relative 'instance_counter.rb'

# Class for route objects
class Route
  include InstanceCounter

  attr_reader :stations, :source, :destination

  def initialize(source, destination)
    @stations = [source, destination]
    @source = source
    @destination = destination
    register_instance
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def remove_station(station)
    @stations.delete(station)
    @source = @stations.first
    @destination = @stations.last
  end

  def to_s
    str = ''
    @stations.each { |station| str += "#{station.title} " }
    str.chomp
  end

  private

  def validate!
    validate_stations
  end

  def validate_stations
    @station.each { |station| raise 'Invalid route' if station.valid? == false }
  end
end
