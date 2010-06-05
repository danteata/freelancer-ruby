module Freelancer
  module Models
    class Account < Base
      
      attr_accessor :username, :userid, :fullname, :company_name, :type_of_work,
                    :picture_url, :addressline1, :addressline2, :city, :state,
                    :country, :postalcode, :phone, :fax, :notificationformat,
                    :emailnotificationstatus, :receivenewsstatus,
                    :bidwonnotificationstatus, :bidplacednotificationstatus,
                    :newprivatemessagestatus, :qualifications, :profiletext,
                    :vision, :keywords, :skills, :hourlyrate,
                    :latest_open_projects, :latest_closed_projects,
                    :latest_frozen_projects, :latest_bids_on_projects,
                    :latest_won_projects, :latest_lost_projects

      # Returns the user's qualifications
      def qualifications; @qualifications ||= []; end
      
      # Returns the latest projects of different types for the user
      def latest_open_projects; @latest_open_projects ||= []; end
      def latest_closed_projects; @latest_closed_projects ||= []; end
      def latest_frozen_projects; @latest_frozen_projects ||= []; end
      def latest_bids_on_projects; @latest_bids_on_projects ||= []; end
      def latest_won_projects; @latest_won_projects ||= []; end
      def latest_lost_projects; @latest_lost_projects ||= []; end
    
    end
  end  
end