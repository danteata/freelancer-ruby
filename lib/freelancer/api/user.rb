module Freelancer
  module API
    module User
      module InstanceMethods

        # Search for users
        #
        # Valid parameters are:
        #   - username: the username to search for
        #   - expertise: a specific expertise, or an array of expertises, to search for
        #   - country: a specific country, or an array of countries, to search for
        #   - rating: the minimum rating to search for
        #   - count: the number of results to return (defaults to 50)
        #   - page: the page to retrieve (defaults to 0)
        def user_search(*args)

          params = extract_params(args)

          # Handle the expertise and country attributes. Make sure they're an array and not set
          # to nil to simplify the handling below.
          params[:country] ||= []
          params[:country] = params[:country].to_a unless params[:country].is_a?(Array)
          params[:expertise] ||= []
          params[:expertise] = params[:expertise].to_a unless params[:expertise].is_a?(Array)

          # Execute the service call
          result = api_get("/User/getUsersBySearch.json", build_api_params({
            :username => params[:username],
            :expertise_csv => params[:expertise].join(","),
            :country_csv => params[:country].join(","),
            :rating => params[:rating],
            :count => params[:count],
            :page => params[:page]
          }))

          # Parse and return the response
          ::Freelancer::Models::User.parse_collection(result, :shift => [ :"json-result", :items ])

        end

        # Search for users
        #
        # Valid parameters are:
        #   - username: the username to list feedback for
        #   - user_id: the user id to list feedback for
        #   - type: the type of feedback to show ("P" = provider only, "B" = buyer only, "A" = all (default))
        def user_feedback(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/User/getUserFeedback.json", build_api_params({
            :username => params[:username],
            :userid => params[:user_id],
            :type => params[:type]
          }))

          # Parse and return the response
          ::Freelancer::Models::Review.parse_collection(result, :shift => [ :user, :totalreviews, :items ])

        end

        # Retrieve user details for a specific user
        #
        # Valid parameters are:
        #   - username: the username to retrieve details for
        #   - user_id: the user id to retrieve details for
        def user_details(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/User/getUserDetails.json", build_api_params({
            :username => params[:username],
            :userid => params[:user_id]
          }))

          # Parse and return the response
          ::Freelancer::Models::User.parse(result, :shift => :user)
          
        end

      end
    end
  end
end
