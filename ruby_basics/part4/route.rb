# API объекта маршрута, кастомной внутренней логики нет, так что все public
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
    @source = @stations.first
    @destination = @stations.last
  end
  
  def to_s
    str = ''
    @stations.each { |station| str += "#{station.title} " }
    str.chomp
  end
end