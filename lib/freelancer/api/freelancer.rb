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

        # Place a bid on a project
        #
        # Valid parameters are:
        #   - project_id: the id of the project to bid on
        #   - amount: the amount of money to offer taking the project for
        #   - description: the bid description
        #   - days: the estimated number of days to complete the project
        #   - notify_on_underbid: if notifications should be send when someone bids lower than this bid
        #   - highlighted: if this bid is highlighted or not
        #   - milestone: declares the initial milestone percentage for the bid
        def bid_on_project(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/Freelancer/placeBidOnProject.json", build_api_params({
            :projectid => params[:project_id],
            :amount => params[:amount],
            :description => params[:description],
            :days => params[:days],
            :notificationStatus => params[:notify_on_underbid],
            :highlighted => params[:highlighted],
            :milestone => params[:milestone]
          }))

          # Parse and return the response
          ::Freelancer::Models::StatusConfirmation.parse(result, :shift => :"json-result")
          
        end

        # Retract a bid from a project
        #
        # Valid parameters are:
        #   - project_id: the id of the project to withdraw bid from
        def retract_bid_from_project(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/Freelancer/retractBidFromProject.json", build_api_params({
            :projectid => params[:project_id]
          }))

          # Parse and return the response
          ::Freelancer::Models::StatusConfirmation.parse(result, :shift => :"json-result")
          
        end

        # Accept a won bid
        #
        # Valid parameters are:
        #   - project_id: the id of the project to accept the offer on
        def accept_won_bid(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/Freelancer/acceptBidWon.json", build_api_params({
            :projectid => params[:project_id]
          }))

          # Parse and return the response
          ::Freelancer::Models::StatusConfirmation.parse(result, :shift => :"json-result")
          
        end

        # Reject a won bid
        #
        # Valid parameters are:
        #   - project_id: the id of the project to reject the offer on
        def reject_won_bid(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/Freelancer/acceptBidWon.json", build_api_params({
            :projectid => params[:project_id],
            :state => 0
          }))

          # Parse and return the response
          ::Freelancer::Models::StatusConfirmation.parse(result, :shift => :"json-result")
          
        end
          
      end
    end
  end
end
