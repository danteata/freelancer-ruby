module Freelancer
  module API
    module Notification
      module InstanceMethods

        # Get a list of available alerts for the current user
        def notifications

          result = api_get("/Notification/getNotification.json")
          ::Freelancer::Models::Notification.parse_collection(result, :shift => [ :"json-result", :items, :notification ])
          
        end

        # Return a list of available news items
        def news

          result = api_get("/Notification/getNews.json")
          ::Freelancer::Models::News.parse_collection(result, :shift => [ :"json-result", :items ])
          
        end

      end
    end
  end
end
