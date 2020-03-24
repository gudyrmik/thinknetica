module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      @instances
    end

    def increse_instances
      @instances += 1
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.increse_instances
    end
  end
end