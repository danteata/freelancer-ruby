module Freelancer
  module Models
    class ProjectFee

      include JSONMapper

      # The project type of the fee
      json_attribute :project_type, :projecttype, String

      # The project description of the fee
      json_attribute :project_description, :projectdesc, String

      # The fee for the project type
      json_attribute :fee, :projectfees, Integer

    end
  end
end
