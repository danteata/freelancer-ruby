module Freelancer
  module API
    module Common
      module InstanceMethods

        # Get a list of projects that are pending feedback
        #
        # Valid parameters are:
        #   - type: the type of projects to list ("P" or "B" (default))
        def pending_feedback(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/Common/getPendingFeedback.json", build_api_params({
            :type => params[:type]
          }))

          # Parse and return the response
          ::Freelancer::Models::Project.parse_collection(result, :shift => [ :"json-result", :items ])
          
        end

        # Get the configuration version of a specific service function
        #
        # Valid parameters are:
        #   - function: the function to look up config version for
        def config_version(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/Common/getConfigVersion.json", build_api_params({
            :function => params[:function]
          }))

          # Parse and return the response
          ::Freelancer::Models::ConfigVersion.parse(result, :shift => :"json-result")
          
        end

        # Returns the current Terms and Conditions from the site
        def terms

          result = api_get("/Common/getTerms.json")
          json = JSONMapper::Parser.parse(result)

          if !json.nil? && json.key?(:"json-result")
            return json[:"json-result"][:terms]
          end
          return nil
          
        end

      end
    end
  end
end
