module Freelancer
  module API
    module User
      module InstanceMethods
        
        # Get the details for the specified username or user id
        def user_details(identifier)
          
          params = {}
          if identifier.is_a?(Fixnum) || identifier =~ /^\d+$/
            params[:userid] = identifier
          else
            params[:username] = identifier
          end

          Models::User.new(api_get("/User/getUserDetails.json", params), "user")

        end
        
        # Search for a set of users using the specified conditions
        def user_search(*args)
          
          params = args.last.is_a?(::Hash) ? args.pop : {}
          
          # If we have an array of expertises or countries specified, join them
          # into a comma separated list
          params[:expertise_csv] = params.delete(:expertise).join(",") if params.key?(:expertise) && params[:expertise].is_a?(Array)
          params[:country_csv] = params.delete(:countries).join(",") if params.key?(:countries) && params[:countries].is_a?(Array)
          
          result = api_get("/User/getUsersBySearch.json", params)
          users = []
          
          # Fetch users from the result set
          if result.keys.first == "xml-result" && result["xml-result"].key?("items") && result["xml-result"]["items"].is_a?(Array)
            result["xml-result"]["items"].each do |item|
              users << Models::User.new(item)
            end
          end
          
          users
          
        end
        
      end
    end
  end
end