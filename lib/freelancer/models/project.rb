module Freelancer
  module Models
    class Project

      include JSONMapper
      
      # The ID of the project
      #
      # Provided from:
      #   - /Profile/getAccountDetails.json
      #   - /Employer/postNewProject.json
      json_attribute :id, [ :id, :projectid ], Integer

      # The name of the project
      #
      # Provided from:
      #   - /Profile/getAccountDetails.json
      #   - /Employer/getPostedProjectList.json
      json_attribute :name, [ :name, :projectname ], String

      # The URL to the project
      #
      # Provided from:
      #   - /Profile/getAccountDetails.json
      #   - /Employer/postNewProject.json
      json_attribute :url, [ :url, :projecturl ], String

      # The short description of the project
      json_attribute :short_description, [ :shortdescr, :short_descr ], String

      # The detailed description of the project
      json_attribute :additional_description, { :additional_descr => :descr_html }, String

      # The status value of the project
      #
      # Provided from:
      #   - /Freelancer/getProjectListForPlacedBids.json
      json_attribute :status, [ :status, :state ], String

      # The additional status value of the project
      #
      # Provided from:
      #   - /Freelancer/getProjectListForPlacedBids.json
      json_attribute :additional_status, :additionalstatus, String

      # The job types associated with the project
      json_attributes :jobs, :jobtypecsv, DelimitedString, :delimiter => ","

      # The job types associated with this project. This is a workaround
      # for the /Project/getProjectDetails.json service which returns the
      # data as an array instead of a comma separated list like the rest of
      # the services. There's some magic in the jobs method below to select
      # the proper one.
      json_attributes :jobs_array, :jobs, String

      # The project options
      json_attribute :options, ProjectOptions

      # The minimum budget for the project
      json_attribute :minimum_budget, { :budget => :min }, Integer

      # The maximum budget for the project
      json_attribute :maximum_budget, { :budget => :max }, Integer

      # The number of bids placed on the project
      #
      # Provided from:
      #   - /Freelancer/getProjectListForPlacedBids.json
      json_attribute :bids, [ :bidcount, :bids, { :bid_stats => :count } ], Integer

      # The average bid for the project
      #
      # Provided from:
      #   - /Freelancer/getProjectListForPlacedBids.json
      json_attribute :average_bid, [ :averagebid, { :bid_stats => :avg } ], Integer

      # The date the project was posted
      #
      # Provided from:
      #   - /Employer/postNewProject.json
      json_attribute :posted_at, :postdatetime, DateTime

      # The date the project starts
      json_attribute :starts_at, [ :startdate, :start_date ], DateTime

      # The date the project ends
      #
      # Provided from:
      #   - /Freelancer/getProjectListForPlacedBids.json
      json_attribute :ends_at, [ :enddate, :end_date ], DateTime

      # The time left before the project ends
      json_attribute :time_left, :timeleft, String

      # The buyer that created the project
      json_attribute :buyer, User

      # The sellers that have bid on the project
      json_attributes :sellers, :seller, User

      # The freelancers selected for this project. This is
      # only available when listing projects where a money
      # transfer can take place.
      json_attributes :selected_freelancers, :selectedfreelancer, User

      # Returns the list of jobs associated with the project. This method
      # selects the "jobs_array" if it exists and has content, otherwise
      # it returns the "jobs" array
      def jobs
        return self.jobs_array unless self.jobs_array.nil? || self.jobs_array.empty?
        return @jobs
      end

    end
  end
end
