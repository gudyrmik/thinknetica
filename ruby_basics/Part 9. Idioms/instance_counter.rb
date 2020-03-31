# frozen_string_literal: true

# Adds automatic instances calculation
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  # Class-level methods
  module ClassMethods
    def instances
      @instances ||= 0
    end

    def increse_instances
      @instances = instances + 1
    end
  end

  # Instance-level methods
  module InstanceMethods
    protected

    def register_instance
      self.class.increse_instances
    end
  end
end
