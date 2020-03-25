module TestModule
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def get_classInstanceVar2
      @classInstanceVar2 ||= 0
    end

    def set_classInstanceVar2(v)
      @classInstanceVar2 = v
    end
  end

  module InstanceMethods
    def get_classInstanceVar2
      self.class.get_classInstanceVar2
    end
  end
end

class A
  include TestModule
end

class B < A
end