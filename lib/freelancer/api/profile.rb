module Freelancer
  module API
    module Profile
      module InstanceMethods
        
        # Get details about the currently authenticated account
        def account_details
          get_profile_info("/Profile/getAccountDetails.json")
        end
        
        # Get details about another user than the currently authenticated
        # account
        def profile_info(user_id)
          get_profile_info("/Profile/getProfileInfo.json", { :userid => user_id })
        end
        
        # Update the details of the current user account
        # TODO: Finish this method. I'm getting an unknown error from the API
        # when calling the method, further investigation of what's going on is
        # needed.
        def update_account_details(account)
          
          # Validate the argument type
          raise ArgumentError("Details must be a Freelancer::Models::Account object") unless account.is_a?(Freelancer::Models::Account)
          
          result = api_get("/Profile/setProfileInfo.json", account.to_json)
          if result.key?(:"xml-result") && result[:"xml-result"].key?(:statusconfirmation) && result[:"xml-result"][:statusconfirmation] == 1
            return true
          end
          false

        end
          
        private

        # Get information about a profile using the specified method and options
        def get_profile_info(method, options = {})
          
          result = api_get(method, options)
          result = result[result.keys.first] if result.keys.first == :"xml-result" # Strip off the outer element
          
          Models::Account.from_json(result)
          
        end
        
      end
    end
  end
end