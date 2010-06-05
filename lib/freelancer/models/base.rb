module Freelancer
  module Models
    class Base
      
      # DSL method for assigning the JSON structure of a model
      def self.json_structure(&structure)
        @@json_structure ||= {}
        @@json_structure[self.to_s.to_sym] = structure if block_given?
      end
      
      # Returns the current JSON DSL
      def self.json_dsl
        @@json_structure ||= {}
        @@json_structure[self.to_s.to_sym]
      end
      
      # Create a new instance of this model and populate the attributes with
      # data from the specified JSON string
      def self.from_json(json)

        raise "No JSON structure DSL defined" if json_dsl.nil?
        
        # puts "Creating new #{self.to_s} from: #{json.inspect}"
        
        model = self.new
        mapper = Support::JSONMapper.new(model)
        mapper.instance_eval(&json_dsl)
        model = mapper.from_json(json)

      end
      
      # Convert the current object to a JSON data structure
      def to_json
        
        raise "No JSON structure DSL defined" if self.class.json_dsl.nil?
        
        mapper = Support::JSONMapper.new(self)
        mapper.instance_eval(&self.class.json_dsl)
        mapper.to_json
        
      end
      
      # Set an attribute on the model using the specified key and value pair.
      # This will throw an exception if the setter-method doesn't exist or is
      # outside of the visible scope.
      def []=(key, value)
        self.send("#{key}=", value)
      end
      
      # Returns the value of an attribute on the model using the specified key
      # This will throw an exception if the getter-method doesn't exist or is
      # outside of the visible scope.
      def [](key)
        self.send("#{key}")
      end

      # Initialize a new instance of the data model.
      def initialize
      end
      
    end
  end
end