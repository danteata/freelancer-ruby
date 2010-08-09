module Freelancer
  module API
    module Freelancer
      module InstanceMethods

        # Get a list of all projects where the specified user have placed a bid.
        # If no user id is specified, the current user is used.
        #
        # Valid parameters are:
        #   - status: the project status to filter the results by (defaults to 2 - open and frozen)
        #   - user_id: the id of the user to retrieve projects for
        #   - project_id: the project id to filter the results by
        #   - count: the number of results to return (defaults to 50)
        #   - page: the page to retrieve (defaults to 0)
        def bid_projects(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/Freelancer/getProjectListForPlacedBids.json", build_api_params({
            :status => params[:status],
            :userid => params[:user_id],
            :projectid => params[:project_id],
            :count => params[:count],
            :page => params[:page]
          }))
          
          # Parse and return the response
          ::Freelancer::Models::Project.parse_collection(result, :shift => [ :"json-result", :items ])
          
        end

      end
    end
  end
end
