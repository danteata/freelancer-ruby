require "test_helper"

class JobCategoryTest < Test::Unit::TestCase

  context "job category model" do
    
    setup do
      @category_json = JSON.parse(fixture_file("job_list.json"), { :symbolize_names => true })[:"xml-result"][:items].first
    end

    should "create an job category instance based on JSON from API" do
      
      category = Freelancer::Models::JobCategory.from_json(@category_json)
      category.category_id.should == "15"
      category.name.should == ".NET"
      category.project_count.should == "7"
      category.seo_url.should == "NET"
      
    end
    
    should "transform a job category back into the same JSON structure it was built from" do
      
      category = Freelancer::Models::JobCategory.from_json(@category_json)
      generated_json = category.to_json
      regenerated_category = Freelancer::Models::JobCategory.from_json(generated_json)
      regenerated_json = regenerated_category.to_json
      
      generated_json.should == regenerated_json
      
    end
    
  end

end
