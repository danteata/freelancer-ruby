module Freelancer
  module API
    module Profile
      module InstanceMethods

        # Retrieve profile information for the current user
        def account_details

          result = api_get("/Profile/getAccountDetails.json")
          ::Freelancer::Models::User.parse(result, :shift => :"json-result")
          
        end

        # Retrieve profile information about a specific user
        #
        # Valid parameters are:
        #   - user_id: the user id to retrieve profile for
        def profile_info(*args)

          params = extract_params(args)

          result = api_get("/Profile/getProfileInfo.json", { :userid => params[:user_id] })
          ::Freelancer::Models::User.parse(result, :shift => :"json-result")

        end

      end
    end
  end
end
