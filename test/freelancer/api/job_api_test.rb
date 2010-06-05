require "test_helper"

class JobApiTest < Test::Unit::TestCase

  context "job api" do
    
    setup do
      
      @freelancer = Freelancer::Client.new("consumer_token", "consumer_secret")
      consumer = OAuth::Consumer.new("consumer_token", "consumer_secret", { :site => "http://api.sandbox.freelancer.com" })
      @freelancer.stubs(:consumer).returns(consumer)
      
      @freelancer.authorize_from_access("access_token", "access_secret")
      
    end
    
    should "return list of job categories" do

      stub_api_get("/Job/getJobList.json", "job_list.json")
      categories = @freelancer.job_categories
      
      categories.size.should == 10
      
      categories.first.category_id.should == "15"
      categories.first.name.should == ".NET"
      categories.first.project_count.should == "7"
      categories.first.seo_url.should == "NET"
      
    end
    
  end

end
