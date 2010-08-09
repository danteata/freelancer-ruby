module Freelancer
  module Models
    class Milestone

      include JSONMapper

      # The id of the milestone
      #
      # Provided from:
      #   - /Payment/getAccountMilestoneList.json
      json_attribute :id, Integer

      # The user id the milestone payment is for
      #
      # Provided from:
      #   - /Payment/getAccountMilestoneList.json
      json_attribute :user_id, :userid, Integer

      # The username the milestone payment is for
      #
      # Provided from:
      #   - /Payment/getAccountMilestoneList.json
      json_attribute :username, String

      # The id of the project the milestone payment is for
      #
      # Provided from:
      #   - /Payment/getAccountMilestoneList.json
      json_attribute :project_id, :projectid, Integer

      # The name of the project the milestone payment is for
      #
      # Provided from:
      #   - /Payment/getAccountMilestoneList.json
      json_attribute :project_name, :projectname, String

      # The amount of money in the milestone payment
      #
      # Provided from:
      #   - /Payment/getAccountMilestoneList.json
      json_attribute :amount, Float

      # The description of the milestone payment
      #
      # Provided from:
      #   - /Payment/getAccountMilestoneList.json
      json_attribute :description, :reason, String

      # The date the milestone was placed
      #
      # Provided from:
      #   - /Payment/getAccountMilestoneList.json
      json_attribute :made_at, :date, DateTime

    end
  end
end
