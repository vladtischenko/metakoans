def attribute(name, default = nil, &block)
	return name.each {|name, default| attribute(name, default)} if name.is_a? Hash
	define_method "#{name}" do
		unless instance_variable_defined? "@#{name}"
			send "#{name}=", block_given? ? instance_eval(&block) : default	
		end
		instance_variable_get "@#{name}" 
	end
	define_method "#{name}=" do |value|
		instance_variable_set "@#{name}", value
	end
	define_method "#{name}?" do
		not send(name).nil?	
	end
end
