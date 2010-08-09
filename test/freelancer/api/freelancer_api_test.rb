require "test_helper"

class FreelancerApiTest < Test::Unit::TestCase

  context "freelancer api" do

    setup do
      @freelancer = Freelancer::Client.new("consumer_token", "consumer_secret")
      consumer = OAuth::Consumer.new("consumer_token", "consumer_secret", { :site => "http://api.sandbox.freelancer.com" })
      @freelancer.stubs(:consumer).returns(consumer)
      @freelancer.authorize_from_access("access_token", "access_secret")
    end

    context "project list for placed bids" do

      should "be able to retrieve" do

        @freelancer.expects(:api_get).with("/Freelancer/getProjectListForPlacedBids.json", {})
        @freelancer.bid_projects

      end

      should "be able to retrieve by status" do

        @freelancer.expects(:api_get).with("/Freelancer/getProjectListForPlacedBids.json", { :status => 1 })
        @freelancer.bid_projects(:status => 1)

      end

      should "be able to retrieve by user id" do

        @freelancer.expects(:api_get).with("/Freelancer/getProjectListForPlacedBids.json", { :userid => 1 })
        @freelancer.bid_projects(:user_id => 1)

      end

      should "be able to retrieve by project id" do

        @freelancer.expects(:api_get).with("/Freelancer/getProjectListForPlacedBids.json", { :projectid => 1 })
        @freelancer.bid_projects(:project_id => 1)

      end

      should "be able to change result count" do
        
        @freelancer.expects(:api_get).with("/Freelancer/getProjectListForPlacedBids.json", { :count => 10 })
        @freelancer.bid_projects(:count => 10)

      end

      should "be able to change result page" do

        @freelancer.expects(:api_get).with("/Freelancer/getProjectListForPlacedBids.json", { :page => 2 })
        @freelancer.bid_projects(:page => 2)

      end

      should "parse response into a collection of projects" do

        stub_api_get("/Freelancer/getProjectListForPlacedBids.json", "freelancer/get_project_list_for_placed_bids.json")
        
        projects = @freelancer.bid_projects
        projects.size.should == 1
        projects.first.id.should == 191

      end

    end

  end

end
