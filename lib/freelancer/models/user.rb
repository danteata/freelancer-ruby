module Freelancer
  module Models
    class User

      include JSONMapper

      # The ID of the user
      #
      # Provided from:
      #   - /User/getUserDetails.json
      #   - /User/getUsersBySearch.json
      #   - /Profile/getAccountDetails.json
      json_attribute :id, [ :id, :userid, :provider_userid, :fromuserid, :touserid ], Integer
      
      # The username of the user
      #
      # Provided from:
      #   - /User/getUserDetails.json
      #   - /User/getUsersBySearch.json
      #   - /Profile/getAccountDetails.json
      json_attribute :username, [ :username, :provider, :fromusername, :tousername ], String

      # The full name of the user
      #
      # Provided from:
      #   - /Profile/getAccountDetails.json
      json_attribute :name, :fullname, String

      # The URL to the profile page of the user
      #
      # Provided from:
      #   - /User/getUserDetails.json
      json_attribute :url, String

      # The URL to the logo for the user
      #
      # Provided from:
      #   - /User/getUserDetails.json
      json_attribute :logo_url, String

      # The URL to the profile logo for the user
      #
      # Provided from:
      #   - /User/getUserDetails.json
      json_attribute :profile_logo_url, String
      
      # The URL to the users picture
      #
      # Provided from:
      #   - /Profile/getAccountDetails.json
      json_attribute :picture_url, String

      # The users address
      #
      # Provided from:
      #   - /User/getUserDetails.json
      #   - /User/getUsersBySearch.json
      #   - /Profile/getAccountDetails.json
      json_attribute :address, [ :address, "self" ], Address

      # The users phone number
      #
      # Provided from:
      #   - /Profile/getAccountDetails.json
      json_attribute :phone_number, :phone, String

      # The users fax number
      #
      # Provided from:
      #   - /Profile/getAccountDetails.json
      json_attribute :fax_number, :fax, String

      # The users profile text
      #
      # Provided from:
      #   - /Profile/getAccountDetails.json
      json_attribute :profile_text, :profiletext, String

      # The users profile vision
      #
      # Provided from:
      #   - /Profile/getAccountDetails.json
      json_attribute :vision, String

      # The users keywords
      #
      # Provided from:
      #   - /Profile/getAccountDetails.json
      json_attribute :keywords, String

      # The date and time when the user was registered at 
      #
      # Provided from:
      #   - /User/getUserDetails.json
      json_attribute :registered_at, :reg_date, DateTime

      # The company the user is representing at 
      #
      # Provided from:
      #   - /User/getUserDetails.json
      #   - /User/getUserBySearch.json
      #   - /Profile/getAccountDetails.json
      json_attribute :company, [ :company, :company_name ], String

      # The type of work the user is registered for
      #
      # Provided from:
      #   - /Profile/getAccountDetails.json
      json_attribute :type_of_work, String

      # The hourly rate for the user
      #
      # Provided from:
      #   - /User/getUserDetails.json
      #   - /Profile/getAccountDetails.json
      json_attribute :hourly_rate, :hourlyrate, Integer

      # The average pricing for the user
      #
      # Provided from:
      #   - /User/getUsersBySearch.json
      json_attribute :average_pricing, :averagepricing, Integer

      # An array of strings specifying what job types the user is accepting
      #
      # Provided from:
      #   - /User/getUserDetails.json
      json_attributes :job_types, :jobs, String

      # An array of strings specifying what skills the user is accepting
      #
      # Provided from:
      #   - /Profile/getAccountDetails.json
      json_attributes :skills, DelimitedString, :delimiter => "\n"

      # An array of strings specifying the users qualifications
      #
      # Provided from:
      #   - /Profile/getAccountDetails.json
      json_attributes :qualifications, :qualificationcsv, DelimitedString

      # The notification status settings for the user
      #
      # Provided from:
      #   - /Profile/getAccountDetails.json
      json_attribute :notifications, "self", NotificationStatus

      # If the user has the gold status enabled
      #
      # Provided from:
      #   - /User/getUserDetails.json
      json_attribute :gold_status, :gold, Boolean

      # The list of open projects where the user is a buyer
      #
      # Provided from:
      #   - /Profile/getAccountDetails.json
      json_attributes :open_buyer_projects, :openBuyerProjectList, Project

      # The list of closed projects where the user is a buyer
      #
      # Provided from:
      #   - /Profile/getAccountDetails.json
      json_attributes :closed_buyer_projects, :closedBuyerProjectList, Project

      # The list of frozen projects where the user is a buyer
      #
      # Provided from:
      #   - /Profile/getAccountDetails.json
      json_attributes :frozen_buyer_projects, :frozenBuyerProjectList, Project

      # The list of bid on projects where the user is a seller
      #
      # Provided from:
      #   - /Profile/getAccountDetails.json
      json_attributes :bid_seller_projects, :bidSellerProjectList, Project

      # The list of won projects where the user is a seller
      #
      # Provided from:
      #   - /Profile/getAccountDetails.json
      json_attributes :won_seller_projects, :wonSellerProjectList, Project

      # The list of lost projects where the user is a seller
      #
      # Provided from:
      #   - /Profile/getAccountDetails.json
      json_attributes :lost_seller_projects, :lostSellerProjectList, Project

      # The users rating
      #
      # Provided from:
      #   - /User/getUserDetails.json
      json_attribute :rating, Rating

      # The users rating as a provider
      #
      # Provided from:
      #   - /User/getUserDetails.json
      json_attribute :provider_rating, Rating

      # The users rating as a buyer
      #
      # Provided from:
      #   - /User/getUserDetails.json
      json_attribute :buyer_rating, Rating

      # The project award status for a user. This is only
      # available when associated with a project as a
      # seller.
      json_attribute :award_status, :awardStatus, String

      # The amount bid for the project. This is only
      # available when associated with a project as the
      # selected freelancer.
      json_attribute :bid_amount, :bidamount, Integer

      # The amount paid for the project. This is only
      # available when associated with a project as the
      # selected freelancer.
      json_attribute :paid_amount, :paidamount, Integer

    end
  end
end
