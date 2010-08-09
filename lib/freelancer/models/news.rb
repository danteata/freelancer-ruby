module Freelancer
  module Models
    class News

      include JSONMapper

      # The id of the news entry
      json_attribute :id, :newsid, Integer

      # The text of the news entry
      json_attribute :text, :newstext, String

    end
  end
end
