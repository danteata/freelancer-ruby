module Freelancer
  module Support
    class JSONMapper
      
      attr_reader :model
      attr_reader :mappings
      
      # Initialize the JSON mapper
      def initialize(model)
        @model = model
        @mappings = {}
      end
      
      # Map a key against the given model value
      def map(from, to)
        @mappings[from] = to
      end
      
      # Build a JSON data structure of the current mapping according to the
      # format specifications from the Freelancer.com API.
      def to_json
        
        # Build a Hash of the current mappings
        structure = {}
        mappings.each_pair do |from, to|
          
          # If our "to" is a hash, build a nested hash into the structure
          if to.is_a?(Hash)
            
            structure[to.keys.first] ||= {}
            structure[to.keys.first][to.values.first] = model[from]
            
          else
            structure[to] = model[from]
          end

        end
        
        structure

      end
      
      # Populate the fields of the model by mapping the JSON data structure
      # specified against the model attributes.
      def from_json(json)
        
        json.each_pair do |key, value|
          
          # If our value is a hash and it's mapped by the mapper,
          # do a special hash lookup on the map target
          # for each of the key+nested key combinations
          if value.is_a?(Hash) && mapped_as_hash?(key)

            value.each_pair do |nested_key, nested_value|
              map_key = mapped_from({ key => nested_key })
              raise ArgumentError.new("Unable to map key #{{ key => nested_key }.inspect} to model attribute") if map_key.nil?
              model[map_key] = nested_value
            end
            
          else
            map_key = mapped_from(key)
            raise ArgumentError.new("Unable to map key #{key} to model attribute") if map_key.nil?
            model[map_key] = value
          end
  

        end
        
        model
                  
      end
      
      private
      
      # Find the "from" key for the given map "to" key
      def mapped_from(to)

        mappings.each_pair do |key, value|
          return key if (value.is_a?(Array) && value.include?(to)) || value == to
        end
        nil

      end
      
      # Check if the specified key is mapped as a hash
      def mapped_as_hash?(key)
        mappings.values.each do |mapping|
          return true if mapping.is_a?(Hash) && mapping.keys.first == key
        end
        false
      end
      
    end
  end
end