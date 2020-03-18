

class Station

  attr_reader :title, :all_trains, :cargo_trains, :passenger_trains

  def initialize(title)
    @title = title
    @all_trains = []
    @cargo_trains = []
    @passenger_trains = []
  end

  def accept_train(train)
    @all_trains << train
    @cargo_trains << train if train.type == 'cargo'
    @passenger_trains << train if train.type == 'passenger'
  end

  def dispatch_train(train)
    @cargo_trains.delete(train)
    @passenger_trains.delete(train)
    @all_trains.delete(train)
  end

end

class Route

  attr_reader :stations

  def initialize(source, destination)
    @stations = [source, destination]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def remove_station(station)
    @stations.delete(station)
  end

  def print
    @stations.each { |station| puts station.title }
  end
end

class Train

  attr_reader :serial_number, :type, :speed, :cars_number

  def initialize(serial_number, type, cars_number)
    @serial_number = serial_number
    @type = type
    @cars_number = cars_number
    @speed = 0
  end

  def current_station
    @current_station.title if @current_station != nil
  end

  def next_station
    @next_station.title if @next_station != nil
  end

  def prev_station
    @prev_station.title if @prev_station != nil
  end

  def accelerate(new_speed)
    @speed = new_speed
  end

  def stop
    @speed = 0
  end

  def add_car
    @cars_number += 1 if @speed == 0 && @cars_number < 50
  end

  def remove_car
    @cars_number -= 1 if @speed == 0 && @cars_number > 0
  end

  def assign_route(route)
    @route = route
    @current_station = @route.stations[0]
    @next_station = @route.stations[1]

    @current_station.accept_train(self)
  end

  def move_forward
    if @next_station != nil
      @current_station.dispatch_train(self)

      @prev_station = @current_station
      @current_station = @next_station
      new_next_station_i = @route.stations.index(@next_station) + 1
      @next_station = @route.stations[new_next_station_i]

      @current_station.accept_train(self)
    end
  end

  def move_backward
    if @prev_station != nil
      @current_station.dispatch_train(self)

      @next_station = @current_station
      @current_station = @prev_station
      new_prev_station_i = @route.stations.index(@prev_station) - 1
      @prev_station = @route.stations[new_prev_station_i]

      @current_station.accept_train(self)
    end
  end

end
