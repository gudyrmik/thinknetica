require_relative 'vendor.rb'

class Car
  include Vendor
  
  attr_reader :type

  def initialize(type)
    @type = type
  end
end