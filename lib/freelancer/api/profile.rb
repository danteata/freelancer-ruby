module Freelancer
  module API
    module Profile
      module InstanceMethods

        # Retrieve profile information for the current user
        def account_details

          result = api_get("/Profile/getAccountDetails.json")
          ::Freelancer::Models::User.parse(result, :shift => :"json-result")
          
        end

        # Update one or more attributes for the current user. This method takes a
        # User object, and this should in most cases have been populated by the
        # account_details method before passed to the update_account_details
        # method to ensure that no data gets lost.
        def update_account_details(account)

          # Prepare a map of update parameters
          params = {}
          params[:fullname] = account.name
          params[:company_name] = account.company
          params[:type_of_work] = account.type_of_work
          params[:addressline1] = account.address.street_name
          params[:addressline2] = account.address.street_name_2
          params[:city] = account.address.city
          params[:state] = account.address.state
          params[:country] = account.address.country
          params[:postalcode] = account.address.postal_code
          params[:phone] = account.phone_number
          params[:fax] = account.fax_number
          params[:notificationformat] = account.notifications.notification_format
          params[:emailnotificationstatus] = account.notifications.email
          params[:receivenewsstatus] = account.notifications.news
          params[:bidwonnotificationstatus] = account.notifications.bid_won
          params[:bidplacednotificationstatus] = account.notifications.bid_placed
          params[:newprivatemessagestatus] = account.notifications.new_private_message
          params[:qualificationcsv] = account.qualifications.join(",")
          params[:profiletext] = account.profile_text
          params[:vision] = account.vision
          params[:keywords] = account.keywords
          params[:hourlyrate] = account.hourly_rate
          params[:skills] = account.skills.join("\n")

          # Execute the service call
          result = api_get("/Profile/setProfileInfo.json", params)

          # Parse and return the response
          ::Freelancer::Models::StatusConfirmation.parse(result, :shift => :"json-result")

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
      module ClassMethods
      end
    end
  end
end
