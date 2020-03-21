# API объекта станции
class Station
  attr_reader :title, :trains
  
  def initialize(title)
    @title = title
    @trains = []
  end
  
  def trains_by_type(type)
    trains.select { |train| train.type == type }
  end
  
  def accept_train(train)
    @trains << train
  end
  
  def dispatch_train(train)
    @trains.delete(train)
  end

  def to_s
    str = "#{@title}"
    @trains.each { |train| str += "\n #{train.to_s} " }
    str.chomp
  end
end