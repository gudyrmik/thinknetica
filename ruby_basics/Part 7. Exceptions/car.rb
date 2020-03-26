require_relative 'vendor.rb'

class Car
  include Vendor
  
  attr_reader :type

  def initialize(type)
    @type = type
    validation_check
  end

  def valid?
    validation_check
    true
  rescue
    false
  end

  private

  def validation_check
    raise 'Invalid car type' if @type != :cargo || @type != :passenger || @type.nil?
end