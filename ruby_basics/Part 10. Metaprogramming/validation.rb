require_relative 'accessors.rb'

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
    self.class_variable_set(:@@validation_list, [])
  end

  module ClassMethods
    def validation_list
      class_variable_get(:@@validation_list)
    end

    def validate(attr, validation_type, format = '')
      validation_list << [attr, validation_type, format]
    end
  end

  module InstanceMethods
    def validate!
      self.class.class_variable_get(:@@validation_list).each do |entry|
        self.send(entry[1], self.instance_variable_get("@#{entry[0]}"), entry[2])
      end
    end

    def valid?
      validate!
    rescue StandardError => e
      puts e.message
      false
    end

    private

    def presence(name, data)
      puts "presence call: #{name}, #{data}"
      raise 'Presence validation failed' if name.empty? || name.nil?
    end

    def type(name, type)
      puts "type call: #{name}, #{type}"
      raise 'Type validation failed' if name.class != type
    end

    def format(name, regexp)
      puts "format call: #{name}, #{regexp}"
      raise 'Format validation failed' if name !~ regexp
    end
  end
end


class Test
  extend Accessors
  include Validation

  attr_accessor_with_history :title
  strong_attr_accessor :age, Integer

  validate :title, :presence
  validate :title, :format, /[A-Za-z]+/
  validate :title, :type, String

  def initialize
    self.title = 'Test1'
    self.title = "Verification"
    self.title = "New title"
    self.age = 19

    puts title_history
    self.valid?
  end  
end