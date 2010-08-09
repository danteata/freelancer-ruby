module Freelancer
  module Models
    class Job

      include JSONMapper

      # The id of the job
      #
      # Provided from:
      #   - /Job/getJobList.json
      json_attribute :id, Integer

      # The name of the job
      #
      # Provided from:
      #   - /Job/getJobList.json
      json_attribute :name, String

      # The number of projects available for the job type
      #
      # Provided from:
      #   - /Job/getJobList.json
      json_attribute :project_count, Integer

      # The SEO URL for the job
      #
      # Provided from:
      #   - /Job/getJobList.json
      json_attribute :seo_url, String

    end
  end
end
