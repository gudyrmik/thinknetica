require_relative 'vendor.rb'

class Car
  include Vendor
  
  attr_reader :type

  def initialize(type)
    @type = type
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
    validate_car_type
  end

  def validate_car_type
    raise 'Invalid car type' if @type != :cargo || @type != :passenger || @type.nil?
end