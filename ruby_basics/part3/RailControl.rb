class Station
  attr_reader :title, :all_trains
  
  def initialize(title)
    @title = title
    @all_trains = []
  end
  
  def trains_by_type(type)
    all_trains.select { |train| train.type == type }
  end
  
  def accept_train(train)
    @all_trains << train
  end
  
  def dispatch_train(train)
    @all_trains.delete(train)
  end
end

class Route
  attr_reader :stations, :source, :destination
  
  def initialize(source, destination)
    @stations = [source, destination]
    @source = source
    @destination = destination
  end
  
  def add_station(station)
    @stations.insert(-2, station)
  end
  
  def remove_station(station)
    @stations.delete(station)
  end
  
  def to_s
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
    @route.source.accept_train(self)
  end
  
  def get_current_station
    @route.stations.find { |station| station.all_trains.include?(self) }
  end
  
  def get_current_station_index
    @route.stations.index(get_current_station)
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
end
