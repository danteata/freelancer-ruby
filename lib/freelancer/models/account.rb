module Freelancer
  module Models
    class Account < Base
      
      # Basic account fields
      attr_accessor :user_id, :username, :full_name, :company_name,
                    :type_of_work, :picture_url
      
      # Address fields
      attr_accessor :address_line_1, :address_line_2, :city, :state, :country,
                    :postal_code

      # Contact fields
      attr_accessor :phone, :fax
      
      # Notification setting fields
      attr_accessor :notification_format, :email_notification_status,
                    :receive_news_status, :bid_won_notification_status,
                    :bid_placed_notification_status, :new_private_message_status

      # Profile fields
      attr_accessor :qualifications, :profile_text, :vision, :keywords, :skills,
                    :hourly_rate

      # Project fields
      attr_accessor :latest_open_projects, :latest_closed_projects,
                    :latest_frozen_projects, :latest_bids_on_projects,
                    :latest_won_projects, :latest_lost_projects

      # Map this data model from/to a JSON structure
      json_structure do
        
        # Basic account fields
        map :user_id, :userid
        map :username, :username
        map :full_name, :fullname
        map :company_name, :company_name
        map :type_of_work, :type_of_work
        map :picture_url, :picture_url
        
        # Address fields
        map :address_line_1, :addressline1
        map :address_line_2, :addressline2
        map :city, :city
        map :state, :state
        map :country, :country
        map :postal_code, :postalcode
        
        # Contact fields
        map :phone, :phone
        map :fax, :fax
        
        # Notification fields
        map :notification_format, :notificationformat
        map :email_notification_status, :emailnotificationstatus
        map :receive_news_status, :receivenewsstatus
        map :bid_won_notification_status, :bidwonnotificationstatus
        map :bid_placed_notification_status, :bidplacednotificationstatus
        map :new_private_message_status, :newprivatemessagestatus
        
        # Profile fields
        map :qualifications_csv, :qualificationcsv
        map :profile_text, :profiletext
        map :vision, :vision
        map :keywords, :keywords
        map :skills, :skills
        map :hourly_rate, :hourlyrate
        
        # Project fields
        map :latest_open_projects_array, :openBuyerProjectList 
        map :latest_closed_projects_array, :closeBuyerProjectList
        map :latest_frozen_projects_array, :frozenBuyerProjectList
        map :latest_bids_on_projects_array, :bidSellerProjectList
        map :latest_won_projects_array, :wonSellerProjectList
        map :latest_lost_projects_array, :lostSellerProjectList

      end
      
      # Builds a list of projects from the array of JSON data
      def latest_open_projects_array=(projects); self[:latest_open_projects] = project_association_array(projects); end
      def latest_closed_projects_array=(projects); self[:latest_closed_projects] = project_association_array(projects); end
      def latest_frozen_projects_array=(projects); self[:latest_frozen_projects] = project_association_array(projects); end
      def latest_bids_on_projects_array=(projects); self[:latest_bids_on_projects] = project_association_array(projects); end
      def latest_won_projects_array=(projects); self[:latest_won_projects] = project_association_array(projects); end
      def latest_lost_projects_array=(projects); self[:latest_lost_projects] = project_association_array(projects); end
      
      # Returns an array of JSON data for any given list of projects
      def latest_open_projects_array; project_association_json(self.latest_open_projects); end
      def latest_closed_projects_array; project_association_json(self.latest_closed_projects); end
      def latest_frozen_projects_array; project_association_json(self.latest_frozen_projects); end
      def latest_bids_on_projects_array; project_association_json(self.latest_bids_on_projects); end
      def latest_won_projects_array; project_association_json(self.latest_won_projects); end
      def latest_lost_projects_array; project_association_json(self.latest_lost_projects); end
      
      # Accessor methods for project arrays - ensures that an empty
      # array is always returned instead of nil
      def latest_open_projects; @latest_open_projects ||= []; end
      def latest_closed_projects; @latest_closed_projects ||= []; end
      def latest_frozen_projects; @latest_frozen_projects ||= []; end
      def latest_bids_on_projects; @latest_bids_on_projects ||= []; end
      def latest_won_projects; @latest_won_projects ||= []; end
      def latest_lost_projects; @latest_lost_projects ||= []; end
      
      # Wrapper method for the CSV-based qualification data
      def qualifications_csv=(csv)
        self.qualifications = csv.nil? ? [] : csv.split(",")
      end
      def qualifications_csv
        self.qualifications.nil? || self.qualifications.empty? ? "" : self.qualifications.join(",")
      end
      
      private
      
      # Build a project association array based on the input data
      def project_association_array(projects)
        
        project_associations = []
        projects.each do |project|
          project_associations << ProjectAssociation.from_json(project)
        end
        
        project_associations
        
      end
      
      # Generate an array of JSON data for the specified project association
      # array.
      def project_association_json(projects)
        
        json_data = []
        projects.each do |project|
          json_data << project.to_json
        end
          
        json_data
        
      end
      
    end
  end  
end