module Freelancer
  module Models
    class ProjectAssociation < Base
      
      # Basic association fields
      attr_accessor :project_id, :name, :url
      
      # Map this data model from/to a JSON structure
      json_structure do
        
        # Basic association fields
        map :project_id, :id
        map :name, :name
        map :url, :url
        
      end
    
    end
  end  
end