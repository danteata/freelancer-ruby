module Freelancer
  module Models
    class User < Base
  
      attr_accessor :url, :id, :username, :logo_url, :reg_unixtime, :reg_date,
                    :company, :gold, :address_country, :address_city,
                    :hourlyrate, :rating_avg, :rating_count,
                    :provider_rating_avg, :provider_rating_count,
                    :buyer_rating_avg, :buyer_rating_count, :jobs
    
      # Returns an array of jobs associated with this user
      def jobs
        @jobs ||= [] # Make sure we have an array and not a nil value
      end
    
      # Returns true if the user has one or more jobs defined
      def jobs?
        !jobs.empty?
      end

    end
  end  
end