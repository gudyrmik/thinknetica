# frozen_string_literal: true

# API for the rail road
class RailRoad
  attr_reader :stations, :trains, :routes

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def add_station(title)
    @stations << Station.new(title)
  end

  def remove_station(station_number)
    @stations.delete_at(station_number - 1)
  end

  def stations_to_s
    str = ''
    @stations.each_with_index { |station, index| str += "[#{index + 1}] - #{station}\n" }
    str
  end

  def add_passenger_train(serial_number)
    @trains << PassengerTrain.new(serial_number)
  end

  def add_cargo_train(serial_number)
    @trains << CargoTrain.new(serial_number)
  end

  def remove_train(train_number)
    @trains.delete_at(train_number - 1)
  end

  def trains_to_s
    str = ''
    @trains.each_with_index { |train, index| str += "[#{index + 1}] - #{train}\n" }
    str
  end

  def add_car_to_train(train_number, car_space)
    train = @trains[train_number - 1]
    train&.add_car(Car.new(train.type, car_space))
    puts "Car with #{car_space} free space added"
  end

  def remove_car_from_train(train_number)
    train = @trains[train_number - 1]
    train&.remove_car
  end

  def add_route(source_number, destination_number)
    source = @stations[source_number - 1]
    destination = @stations[destination_number - 1]
    @routes << Route.new(source, destination) if !source.nil? && !destination.nil?
  end

  def remove_route(route_number)
    @routes.delete_at(route_number - 1)
  end

  def routes_to_s
    str = ''
    @routes.each_with_index { |route, index| str += "[#{index + 1}] - #{route}\n" }
    str
  end

  def add_station_to_route(station_number, route_number)
    station = @stations[station_number - 1]
    route = @routes[route_number - 1]
    route.add_station(station) if !station.nil? && !route.nil?
  end

  def remove_station_from_route(station_number, route_number)
    route = @routes[route_number - 1]
    station = route.stations[station_number - 1]
    route.remove_station(station) if !station.nil? && !route.nil?
  end

  def assign_train_on_route(train_number, route_number)
    train = @trains[train_number - 1]
    route = @routes[route_number - 1]
    train.assign_route(route) if !train.nil? && !route.nil?
  end

  def train_move_forward(train_number)
    train = @trains[train_number - 1]
    train.move_forward if !train.nil? && !train.route.nil?
  end

  def train_move_backward(train_number)
    train = @trains[train_number - 1]
    train.move_backward if !train.nil? && !train.route.nil?
  end
end
