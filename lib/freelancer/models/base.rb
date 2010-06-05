module Freelancer
  module Models
    class Base
      
      # Set an attribute on the model using the specified key and value pair
      def set_attribute(key, value)
        self.send("#{key}=", value) if self.respond_to?("#{key}=")
      end  

      # Initialize a new instance of the data model. It expects a hash
      # containing the fields to be set on the model.
      def initialize(params = {}, wrapper_element = nil)
        
        params = {} if !params.is_a?(Hash) or params.nil?
        
        # Strip off the wrapper element if specified and round
        params = params[wrapper_element] if !wrapper_element.nil? && params.keys.first == wrapper_element
        
        unless params.nil? || params.empty?
          params.each_pair do |key, value|
            
            if value.is_a?(Hash)
              
              # If the value is a hash, take the key of the current param and
              # append the key of each item in the value hash and set those as
              # model parameters.
              value.each_pair do |inner_key, inner_value|
                self.set_attribute("#{key}_#{inner_key}", inner_value)
              end
              
            else
              
              # Otherwise, just set the value as-is on the model
              self.set_attribute(key, value)
              
            end
            
          end
        end

      end
      
    end
  end
end