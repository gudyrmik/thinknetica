class Station
  attr_reader :title, :all_trains
  def initialize(title)
    @title = title
    @all_trains = []
  end
  def get_trains(type = 'all')
    case type
    when 'all'
      all_trains.each { |train| puts "#{train}" }
    when 'cargo'
      all_trains.each { |train| puts "#{train}" if train.type == 'cargo' }
    when 'passenger'
      all_trains.each { |train| puts "#{train}" if train.type == 'passenger' }
    end
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
  def move(direction)
    current_station_index = -1
    @route.stations.each do |station|
      current_station_index = @route.stations.index(station) if station.all_trains.include?(self)
      break if current_station_index != -1
    end
    # вопрос - как написать этот блок по-человечески (на Руби:))?
    # нутром чую что Сишная конструкция вида переменная сверху и вычисляющий цикл
    # ниже в Руби можно написать красиво, но не соображу:(
    break if current_station_index == -1
    case direction
    when 'forward'
      if current_station_index + 1 < @route.stations.size - 1
        @route.stations[current_station_index].dispatch_train(self)
        @route.stations[current_station_index + 1].accept_train(self)
      end
    when 'backward'
      if current_station_index - 1 >= 0
        @route.stations[current_station_index].dispatch_train(self)
        @route.stations[current_station_index - 1].accept_train(self)
    end
  end
end