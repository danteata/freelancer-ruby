module Freelancer
  module Models
    class Eligibility

      include JSONMapper

      # If the user is eligible for the requested action
      #
      # Provided from:
      #   - /Employer/eligibleForTrialProject.json
      json_attribute :eligible, Boolean

      # The number of bonus point the user has
      #
      # Provided from:
      #   - /Employer/eligibleForTrialProject.json
      json_attribute :bonus_points, :bonuspoints, Integer

      def eligible?; self.eligible; end

    end
  end
end
