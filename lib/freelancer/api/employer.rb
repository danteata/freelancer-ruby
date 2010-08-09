module Freelancer
  module API
    module Employer
      module InstanceMethods

        # Retrieve a list of projects posted by a user. By default, this
        # retrieves the projects posted by the currently authenticated user.
        #
        # Valid parameters are:
        #   - status: the status value to filter projects by (defaults to 2 (open and frozen))
        #   - user_id: the id of the user to list projects for (defaults to current user)
        #   - project_id: the project id to filter projects by
        #   - type: the project type to use ('active', 'trial' and 'draft' - defaults to 'active')
        #   - count: the number of results to return (defaults to 50)
        #   - page: the page to retrieve (defaults to 0)
        def posted_projects(*args)

          params = extract_params(args)

          # Use a blank type value if type is set to 'active'
          params[:type] = nil if params[:type] == "active"

          # Execute the service call
          result = api_get("/Employer/getPostedProjectList.json", build_api_params({
            :status => params[:status],
            :userid => params[:user_id],
            :projectid => params[:project_id],
            :projectoption => params[:type],
            :count => params[:count],
            :page => params[:page]
          }))

          # Parse and return the response
          ::Freelancer::Models::Project.parse_collection(result, :shift => [ :"json-result", :items ])
          
        end

        # Check if the current user is eligible to post trial projects
        def eligible_for_trial_project
          
          result = api_get("/Employer/eligibleForTrialProject.json")
          ::Freelancer::Models::Eligibility.parse(result, :shift => :"json-result")

        end

        # Returns true if the current user is eligible to post trial projects,
        # false otherwise
        def eligible_for_trial_project?
          eligibility = eligible_for_trial_project
          !eligibility.nil? && eligibility.eligible?
        end

      end
    end
  end
end
