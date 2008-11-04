class Test::Unit::TestCase
  def self.should_have_instance_variables(object_string, *vars)
    vars.each do |var|
      should "have instance variable '#{var}'" do
        assert_contains eval(object_string.to_s).instance_variables, "@#{var}"
      end
    end
  end

  def self.should_respond_to(object_string, *methods)
    methods.each do |method|
      should "respond to ##{method}" do
        assert eval(object_string.to_s).respond_to?(method)
      end
    end
  end

  def self.should_call(object_string, method)
    should "receive a :#{method} message" do
      object = eval(object_string.to_s)
      
      object.instance_eval <<-EOF
        alias :__#{method} :#{method}
        def #{method}(*args, &block)
          @method_calls ||= {}
          @method_calls['#{method}'.to_sym] = true
          __#{method} *args, &block
        end
      EOF

      yield object

      assert object.instance_eval { @method_calls[method] }
    end
  end
end
