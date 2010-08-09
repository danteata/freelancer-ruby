module Freelancer
  module Models
    class StatusConfirmation

      include JSONMapper

      # Status confirmation value
      json_attribute :success, :statusconfirmation, Boolean

      def success?; return self.success; end

      # Method missing method for handling additional data on a
      # status confirmation transparently. This will check the JSON model
      # associated with the current status confirmation and see if the
      # missing method name is available as a key at the root level of the
      # JSON model.
      def method_missing(id, *args)

        if !json_data.nil? && json_data.key?(id.to_sym)
          return json_data[id.to_sym]
        end
        raise NoMethodError
        
      end

    end
  end
end
