module Freelancer
  module Models
    class NotificationStatus

      include JSONMapper

      # The notification format setting
      #
      # Provided from:
      #   - /Profile/getAccountDetails.json
      json_attribute :notification_format, :notificationformat, String

      # If e-mail notifications have been enabled
      #
      # Provided from:
      #   - /Profile/getAccountDetails.json
      json_attribute :email, :emailnotificationstatus, Boolean

      # If news notifications have been enabled
      #
      # Provided from:
      #   - /Profile/getAccountDetails.json
      json_attribute :news, :receivenewsstatus, Boolean

      # If bid won notifications have been enabled
      #
      # Provided from:
      #   - /Profile/getAccountDetails.json
      json_attribute :bid_won, :bidwonnotificationstatus, Boolean

      # If bid placed notifications have been enabled
      #
      # Provided from:
      #   - /Profile/getAccountDetails.json
      json_attribute :bid_placed, :bidplacednotificationstatus, Boolean

      # If private message notifications have been enabled
      #
      # Provided from:
      #   - /Profile/getAccountDetails.json
      json_attribute :new_private_message, :newprivatemessagestatus, Boolean

    end
  end
end
