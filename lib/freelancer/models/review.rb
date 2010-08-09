module Freelancer
  module Models
    class Review

      include JSONMapper

      # The username of the user that wrote the review
      #
      # Provided from:
      #   - /User/getUserFeedback.json
      json_attribute :reviewer_username, :reviewername, String

      # The user id of the user that wrote the review
      #
      # Provided from:
      #   - /User/getUserFeedback.json
      json_attribute :reviewer_id, :revieweruserid, Integer

      # The username of the user that received the review
      #
      # Provided from:
      #   - /Common/getPendingFeedback.json
      json_attribute :username, String

      # The id of the user that received the review
      #
      # Provided from:
      #   - /Common/getPendingFeedback.json
      json_attribute :user_id, :userid, Integer

      # The name of the project that has been reviewed
      #
      # Provided from:
      #   - /User/getUserFeedback.json
      json_attribute :project_name, :projectname, String

      # The id of the project that has been reviewed
      #
      # Provided from:
      #   - /User/getUserFeedback.json
      json_attribute :project_id, :projectid, Integer

      # The amount of the winning bid
      #
      # Provided from:
      #   - /User/getUserFeedback.json
      json_attribute :winning_bid, :winnerbid, Integer

      # The date which the ability to rate ends for this project
      #
      # Provided from:
      #   - /Common/getPendingFeedback.json
      json_attribute :rateable_until, :rateuntil, DateTime
      
      # The status of the project in regards to the feedback
      #
      # Provided from:
      #   - /Common/getPendingFeedback.json
      json_attribute :status, String

      # The date of the review
      #
      # Provided from:
      #   - /User/getUserFeedback.json
      json_attribute :reviewed_at, :reviewdate, DateTime

      # The rating of the review
      #
      # Provided from:
      #   - /User/getUserFeedback.json
      json_attribute :rating, Integer

      # The comment of the review
      #
      # Provided from:
      #   - /User/getUserFeedback.json
      json_attribute :comment, :commenttext, String

      # The reviewed users reply on the feedback
      #
      # Provided from:
      #   - /User/getUserFeedback.json
      json_attribute :reply, :userreplyoncomment, String

    end
  end
end
