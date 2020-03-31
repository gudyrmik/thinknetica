# frozen_string_literal: true

require_relative 'vendor.rb'

# Class for car's objects used in a Rail Road app.
class Car
  include Vendor

  attr_reader :type, :total_space, :id

  class << self
    attr_accessor :id
  end

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
    self.class.id ||= 0
    @type = type.to_sym
    @total_space = total_space
    @used_space = 0
    @id = self.class.id
    self.class.id += 1
    validate!
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  private

  def validate!
    validate_type
    validate_space
  end

  def validate_type
    raise ArgumentError, 'Unknown car type' unless (@type == :cargo) || (@type == :passenger)
    raise TypeError, 'Car type can\'t be empty' if @type.nil?
  end

  def validate_space
    raise ArgumentError, 'Car space should be have positive value' if @total_space <= 0
    raise ArgumentError, 'Car space should be integer' if @total_space.class != Integer
    raise TypeError, 'Car space can\'t be empty' if @total_space.nil?
  end
end
