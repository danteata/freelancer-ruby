module Freelancer
  module Models
    class Project < Base
  
      # Project basics
      attr_accessor :project_id, :name, :url, :starts_at_epoch, :starts_at_date,
                    :ends_at_epoch, :ends_at_date, :state, :short_description,
                    :additional_description, :additional_files
                    
      # Associations
      attr_accessor :buyer, :sellers
      
      # Options
      attr_accessor :featured, :non_public, :trial, :full_time,
                    :for_gold_members, :hidden_bids
                    
      # Budget
      attr_accessor :min_budget, :max_budget
      
      # Categorization
      attr_accessor :jobs
      
      # Bids
      attr_accessor :bid_count, :average_bid
      
      # Map this data model from/to a JSON structure
      json_structure do
        
        # Project basics
        map :project_id, :id
        map :name, :name
        map :url, :url
        map :starts_at_epoch, :start_unixtime
        map :starts_at_date, :start_date
        map :ends_at_epoch, :end_unixtime
        map :ends_at_date, :end_date
        map :state, :state
        map :short_description, :short_descr
        map :additional_description, :additional_descr
        map :additional_files, :additional_files

        # Associations
        map :buyer_json, :buyer
        map :sellers_array, :seller
        
        # Options
        map :featured, { :options => :featured }
        map :non_public, { :options => :nonpublic }
        map :trial, { :options => :trial }
        map :full_time, { :options => :fulltime }
        map :for_gold_members, { :options => :for_gold_members }
        map :hidden_bids, { :options => :hidden_bids }
                      
        # Budget
        map :min_budget, { :budget => :min }
        map :max_budget, { :budget => :max }
        
        # Categorization
        map :jobs, :jobs
        
        # Bids
        map :bid_count, { :bid_stats => :count }
        map :average_bid, { :bid_stats => :avg }

      end
      
      # Associate the project with a buyer from JSON data
      def buyer_json=(json)
        self.buyer = User.from_json(json)
      end
      
      # Return the JSON representation of the buyer
      def buyer_json
        self.buyer.to_json
      end
      
      # Associate the project with sellers from an array with
      # JSON data
      def sellers_array=(sellers)
        self.sellers = []
        sellers.each do |s|
          self.sellers << User.from_json(s)
        end
      end
      
      # Return an array of JSON containing the project sellers
      def sellers_array
        json = []
        self.sellers.each do |s|
          json << s.to_json
        end
        json
      end

    end
  end  
end