module Freelancer
  module Models
    class JobCategory < Base
  
      # Basic category fields
      attr_accessor :category_id, :name, :project_count, :seo_url

      # Map this data model from/to a JSON structure
      json_structure do
        
        map :category_id, :id
        map :name, :name
        map :project_count, :project_count
        map :seo_url, :seo_url

      end

    end
  end  
end