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
        def update_account_details(details)
          
          # Validate the argument type
          raise ArgumentError("Details must be a Freelancer::Models::Account object") unless details.is_a?(Freelancer::Models::Account)
          
          # Create a JSON body from the object
          params = {
            :fullname => details.fullname,
            :company_name => details.company_name,
            :type_of_work => details.type_of_work,
            :addressline1 => details.addressline1,
            :addressline2 => details.addressline2,
            :city => details.city,
            :state => details.state,
            :country => details.country,
            :postalcode => details.postalcode,
            :phone => details.phone,
            :fax => details.fax,
            :notificationformat => details.notificationformat,
            :emailnotificationstatus => details.emailnotificationstatus,
            :receivenewsstatus => details.receivenewsstatus,
            :bidwonnotificationstatus => details.bidwonnotificationstatus,
            :newprivatemessagestatus => details.newprivatemessagestatus,
            :qualificationcsv => details.qualifications.join(","),
            :profiletext => details.profiletext,
            :vision => details.vision,
            :keywords => details.keywords,
            :hourlyrate => details.hourlyrate,
            :skills => details.skills
          }
          
          # Remove any nil value params
          params.keys.each do |k|
            params.delete(k) if params[k].nil?
          end
          
          result = api_get("/Profile/setProfileInfo.json", params)
          if result.key?("xml-result") && result["xml-result"].key?("statusconfirmation") && result["xml-result"]["statusconfirmation"] == 1
            return true
          end
          false

        end
          
        private

        # Get information about a profile using the specified method and options
        def get_profile_info(method, options = {})
          
          result = api_get(method, options)
          result = result[result.keys.first] if result.keys.first == "xml-result" # Strip off the outer element
          
          # Convert the qualification csv string to an array if found
          result[:qualifications] = result.delete("qualificationcsv").split(",") if result.key?("qualificationcsv") && !result["qualificationcsv"].nil?
          
          # Build the main account model
          account = Models::Account.new(result)
          
          # Add any project associations to this account
          account.latest_open_projects = project_associations_for_type("openBuyer", result)
          account.latest_closed_projects = project_associations_for_type("closeBuyer", result)
          account.latest_frozen_projects = project_associations_for_type("frozenBuyer", result)
          account.latest_bids_on_projects = project_associations_for_type("bidSeller", result)
          account.latest_won_projects = project_associations_for_type("wonSeller", result)
          account.latest_lost_projects = project_associations_for_type("lostSeller", result)
          
          account
          
        end
        
        # Retrieve any project associations for a set of account details
        def project_associations_for_type(type, data)
          
          type_key = "#{type}ProjectList"
          projects = []

          if data.key?(type_key) && data[type_key].is_a?(Array)
            data[type_key].each do |project|
              projects << Models::ProjectAssociation.new(project)
            end
          end
          
          projects
          
        end
        
      end
    end
  end
end