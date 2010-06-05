module Freelancer
  module Models
    class User < Base
  
      # Basic user information
      attr_accessor :user_id, :username, :url, :logo_url, :registered_at_epoch,
                    :registered_at_date, :company_name, :gold, :hourly_rate
                    
      # Address information
      attr_accessor :country, :city
      
      # Rating
      attr_accessor :avg_rating, :rating_count, :avg_buyer_rating,
                    :buyer_rating_count, :avg_provider_rating,
                    :provider_rating_count
                    
      # Categorization
      attr_accessor :jobs
      
      # Attributes specific to a user when loaded on a project
      attr_accessor :award_status
      
      # Attributes specific to a user when loaded in a search result
      attr_accessor :average_pricing

      # Map this data model from/to a JSON structure
      json_structure do
        
        # Basic user information
        map :user_id, [ :id, :userid ]
        map :username, :username
        map :url, :url
        map :logo_url, :logo_url
        map :registered_at_epoch, :reg_unixtime
        map :registered_at_date, :reg_date
        map :company_name, :company
        map :gold, :gold
        map :hourly_rate, :hourlyrate
        
        # Address information
        map :country, { :address => :country }
        map :city, { :address => :city }
        
        # Rating
        map :avg_rating, { :rating => :avg }
        map :rating_count, { :rating => :count }
        map :avg_buyer_rating, { :buyer_rating => :avg }
        map :buyer_rating_count, { :buyer_rating => :count }
        map :avg_provider_rating, { :provider_rating => :avg }
        map :provider_rating_count, { :provider_rating => :count }
        
        # Jobs
        map :jobs, :jobs

        # Attributes specific to a user when loaded on a project
        map :award_status, :awardStatus
        
        # Attributes specific to a user when loaded in a search reuslt
        map :average_pricing, :averagepricing
        
      end

    end
  end  
end