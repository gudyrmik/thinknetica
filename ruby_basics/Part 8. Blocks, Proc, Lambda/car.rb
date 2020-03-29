require_relative 'vendor.rb'

class Car
  include Vendor
  
  attr_reader :type, :total_space, :id

  @@id = 0

  def to_s
    "id: #{@id}, type: #{@type}, used space: #{@used_space}, total space: #{@total_space}"
  end

  def take_space
    @used_space += 1 if @used_space < @total_space
  end

  def free_space
    @total_space - @used_space
  end

  def initialize(type, total_space)
    @type = type.to_sym
    @total_space = total_space
    @used_space = 0
    @id = @@id
    @@id += 1
    validate!
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  private

  def validate!
    validate_type
    validate_space
  end

  def validate_type
    raise ArgumentError.new 'Unknown car type' unless @type == :cargo or @type == :passenger
    raise TypeError.new 'Car type can\'t be empty' if @type.nil?
  end

  def validate_space
    raise ArgumentError.new 'Car space should be have positive value' if @total_space <= 0 
    raise ArgumentError.new 'Car space should be integer' if @total_space.class != Integer
    raise TypeError.new 'Car space can\'t be empty' if @total_space.nil?
  end
end