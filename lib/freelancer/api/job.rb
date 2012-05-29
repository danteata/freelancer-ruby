module Freelancer
  module API
    module Job
      module InstanceMethods

        # Retrieve a list of available jobs
        def jobs

          result = api_get("/Job/getJobList.json")
          ::Freelancer::Models::Job.parse_collection(result, :shift => [ :"json-result", :items ])
          
        end

        # Retrieve a list of available job categories
        def job_categories
          
          result = api_get("/Job/getCategoryJobList.json")
          ::Freelancer::Models::JobCategory.parse_collection(result, :shift => [ :"json-result", :items, :category ])

        end

        # Retrieve a list of the current users jobs
        def my_jobs
          
          result = api_get("/Job/getMyJobList.json")

          # We need to hack this to make the job id a sub element of the
          # job node to make the mapping work properly.
          json_result = JSONMapper::Parser.parse(result)
          jobs = []
          unless json_result.nil?

            json_result[:"json-result"][:items][:job].each do |item|
              jobs << { :id => item }
            end

          end

          ::Freelancer::Models::Job.parse_json_collection(jobs)

        end

      end
      module ClassMethods

      end
    end
  end
end
