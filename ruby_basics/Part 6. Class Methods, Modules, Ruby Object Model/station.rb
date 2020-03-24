require_relative 'instance_counter.rb'

class Station
  include InstanceCounter

  @instances = 0

  attr_reader :title, :trains

  def self.all
    @@obj_references
  end
  
  def initialize(title)
    @title = title
    @trains = []
    @@obj_references << self
    register_instance
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

  private

  @@obj_references = []
end