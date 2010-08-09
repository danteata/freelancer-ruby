module Freelancer
  module Models
    class JobCategory

      include JSONMapper

      # The id of the category
      json_attribute :id, Integer

      # The name of the category
      json_attribute :name, String

      # The list of jobs associated with the category
      json_attributes :jobs, :job, Job

    end
  end
end
