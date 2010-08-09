module Freelancer
  module Models
    class ConfigVersion

      include JSONMapper

      # The function requested
      #
      # Provided from:
      #   - /Common/getConfigVersion.json
      json_attribute :function, String

      # The version of the requested function
      #
      # Provided from:
      #   - /Common/getConfigVersion.json
      json_attribute :version, Integer

    end
  end
end
