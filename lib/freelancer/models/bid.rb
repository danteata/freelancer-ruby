module Freelancer
  module Models
    class Bid

      include JSONMapper

      # The provider that made the bid
      json_attribute :provider, "self", User

      # The rating of the provider
      json_attribute :provider_rating, :rating, Float

      # The bid amount
      json_attribute :amount, :bid_amount, Integer

      # The milestone payment requirements
      json_attribute :milestone, String

      # If the bid is highlighted
      json_attribute :highlighted, Boolean

      # The number of days in the bid
      json_attribute :days, :period, Integer

      # The bid description
      json_attribute :description, :descr, String

      # The time the bid was placed
      json_attribute :submitted_at, :submittime, DateTime

      # The number of messages between the seller and bidder on this project
      json_attribute :total_messages, :total_msg_count, Integer

      # The number of unread messages between the seller and bidder on this project
      json_attribute :unread_messages, :unread_msg_count, Integer

      def highlighted?; return self.highlighted; end

    end
  end
end
