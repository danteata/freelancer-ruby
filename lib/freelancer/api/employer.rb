module Freelancer
  module API
    module Employer
      module InstanceMethods
        
        # Post a new project
        def post_project
          
          result = api_get("/Job/getJobList.json")
          categories = []
          
          # Fetch categories from the result set
          if result.keys.first == "xml-result" && result["xml-result"].key?("items") && result["xml-result"]["items"].is_a?(Array)
            result["xml-result"]["items"].each do |item|
              categories << Models::JobCategory.new(item)
            end
          end
          
          categories
          
        end
        
      end
    end
  end
end