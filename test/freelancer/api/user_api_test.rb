require "test_helper"

class UserApiTest < Test::Unit::TestCase

  context "user api" do
    
    setup do
      
      @freelancer = Freelancer::Client.new("consumer_token", "consumer_secret")
      consumer = OAuth::Consumer.new("consumer_token", "consumer_secret", { :site => "http://api.sandbox.freelancer.com" })
      @freelancer.stubs(:consumer).returns(consumer)
      
      @freelancer.authorize_from_access("access_token", "access_secret")
      
    end
    
    should "query by username for non-numeric identifiers" do
      
      @freelancer.expects(:api_get).with("/User/getUserDetails.json", { :username => "test" })
      @freelancer.user_details("test")
      
    end
    
    should "query by userid for numeric identifiers" do
      
      @freelancer.expects(:api_get).with("/User/getUserDetails.json", { :userid => 12345 }).returns({})
      @freelancer.user_details(12345)
      
    end
    
    should "retrieve user details for an authenticated user" do
      
      stub_api_get("/User/getUserDetails.json?username=test", "user_details.json")
      user = @freelancer.user_details("test")
      
      user.username.should == "binarymarbles"
      
    end
    
    context "search" do
      
      should "expand countries array to country_csv parameter" do
        
        @freelancer.expects(:api_get).with("/User/getUsersBySearch.json", { :country_csv => "Australia,Norway" }).returns({})
        @freelancer.user_search(:countries => [ "Australia", "Norway" ])
        
      end
      
      should "expand expertise array to expertise_csv parameter" do

        @freelancer.expects(:api_get).with("/User/getUsersBySearch.json", { :expertise_csv => "Ruby,PostgreSQL" }).returns({})
        @freelancer.user_search(:expertise => [ "Ruby", "PostgreSQL" ])

      end
    
      should "retrieve users from a search for an authenticated user" do
        
        stub_api_get("/User/getUsersBySearch.json?username=test", "user_search.json")
        users = @freelancer.user_search(:username => "test")
        
        users.size.should == 2
        users.first.username.should == "test1"
        users.last.username.should == "test2"
        
      end
      
    end
    
  end

end
