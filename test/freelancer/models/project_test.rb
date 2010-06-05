require "test_helper"

class ProjectTest < Test::Unit::TestCase

  context "project model" do
    
    setup do
      @project_json = JSON.parse(fixture_file("project_details.json"), { :symbolize_names => true })[:project]
    end

    should "create a project based on JSON from API" do
      
      project = Freelancer::Models::Project.from_json(@project_json)
      
      project.project_id.should == 148
      project.name.should == "Test project to get some reviews on my account"
      project.url.should == "http://www.sandbox.freelancer.com/projects/NET/Test-project-get-some-reviews.html"
      project.starts_at_epoch.should == 1275702518
      project.starts_at_date.should == "2010-06-04 21:48:38"
      project.ends_at_epoch.should == 1276134518
      project.ends_at_date.should == "2010-06-09 21:48:38"
      project.state.should == "F"
      project.short_description.should == "This is just a test project."
      project.additional_description.should == nil
      project.additional_files.should == nil
      
      project.buyer.user_id.should == 1619837
      project.buyer.username.should == "binarymarbles"
      project.buyer.url.should == "http://www.sandbox.freelancer.com/users/1619837.html"
      
      project.sellers.size.should == 1
      project.sellers.first.user_id.should == 1619838
      project.sellers.first.username.should == "mariellejl"
      
      project.featured.should == 0
      project.non_public.should == 0
      project.trial.should == 0
      project.full_time.should == 0
      project.for_gold_members.should == 0
      project.hidden_bids.should == 0
      
      project.min_budget.should == 250
      project.max_budget.should == 750
      
      project.jobs.should == [".NET"]
      
      project.bid_count.should == 1
      project.average_bid.should == 500
      
    end

    should "transform a project back into the same JSON structure it was built from" do
      
      project = Freelancer::Models::Project.from_json(@project_json)
      generated_json = project.to_json
      regenerated_project = Freelancer::Models::Project.from_json(generated_json)
      regenerated_json = regenerated_project.to_json
      
      generated_json.should == regenerated_json
      
    end
  
  end

end
