module Freelancer
  module Models
    class Message

      include JSONMapper

      # The id of the message
      json_attribute :id, Integer

      # Sender or recipient of the message
      json_attribute :user, "self", User

      # The project id related to the message
      json_attribute :project_id, :projectid, Integer

      # The date the message was sent
      json_attribute :sent_at, :datetime, DateTime

      # The message text
      json_attribute :text, String

      # The url to the attachment
      json_attribute :attachment_url, :attachmentlink, String

      # If the message has been read
      json_attribute :new, Boolean

      def new?; return self.new; end

    end
  end
end
