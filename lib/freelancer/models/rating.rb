module Freelancer
  module Models
    class Rating

      include JSONMapper

      # The average rating
      #
      # Provided from:
      #   - /User/getUserDetails.json
      json_attribute :average, :avg, Integer

      # The number of ratings
      #
      # Provided from:
      #   - /User/getUserDetails.json
      json_attribute :count, Integer

    end
  end
end
