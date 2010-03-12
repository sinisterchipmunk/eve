module Eve
  class API
    class Response
      module WrapObject
        def wrap_object(method_name, value)
          klass = (class << self; self; end)
          underscored = method_name.to_s.underscore
          klass.send(:attr_reader, underscored)
          klass.send(:delegate, method_name, :to => underscored) unless method_name == underscored
          instance_variable_set("@#{underscored}", value)
        end
      end
    end
  end
end
