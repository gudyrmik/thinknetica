module Accessors
  def attr_accessor_with_history(*attr_names)
    attr_names.each do |attr_name|
      var_name = "@#{attr_name}".to_sym
      history_arr_name  = "@#{attr_name}_history".to_sym
      
      define_method(attr_name) { instance_variable_get(var_name) }
      
      define_method("#{attr_name}=".to_sym) do |value|
        puts "history_arr_name = #{history_arr_name}"
        instance_variable_set(history_arr_name, []) if !instance_variable_get(history_arr_name)
        instance_variable_get(history_arr_name) << value
        instance_variable_set(var_name, value)
      end

      define_method("#{attr_name}_history") { instance_variable_get(history_arr_name) }
    end
  end

  def strong_attr_accessor(attr_name, attr_class)
    var_name = "@#{attr_name}".to_sym

    define_method(attr_name) { instance_variable_get(var_name) }
    define_method("#{attr_name}=".to_sym) do |value|
      raise TypeError unless value.class == attr_class
      instance_variable_set(var_name, value)
    end
  end
end