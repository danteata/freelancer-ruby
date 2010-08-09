module Freelancer
  module Models
    class Notification

      include JSONMapper

      # The description of the notification
      json_attribute :description, :notificationtext, String

      # The URL to the notification
      json_attribute :url, String

    end
  end
end
