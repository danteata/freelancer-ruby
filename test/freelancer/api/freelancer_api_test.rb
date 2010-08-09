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

    context "bid on a project" do

      should "be able to push bid" do

        @freelancer.expects(:api_get).with("/Freelancer/placeBidOnProject.json", { :projectid => 1, :amount => 100, :days => 10, :description => "Test" })
        @freelancer.bid_on_project(:project_id => 1, :amount => 100, :days => 10, :description => "Test")

      end

      should "parse response into a status confirmation model" do

        stub_api_get("/Freelancer/placeBidOnProject.json", "status_confirmation.json")
        status = @freelancer.bid_on_project
        status.success?.should == true

      end

    end

    context "retract bid from project" do

      should "be able to retract bid" do

        @freelancer.expects(:api_get).with("/Freelancer/retractBidFromProject.json", { :projectid => 1 })
        @freelancer.retract_bid_from_project(:project_id => 1)

      end

      should "parse response into a status confirmation model" do

        stub_api_get("/Freelancer/retractBidFromProject.json", "status_confirmation.json")
        status = @freelancer.retract_bid_from_project
        status.success?.should == true

      end

    end

    context "accept won project" do

      should "be able to accept project" do

        @freelancer.expects(:api_get).with("/Freelancer/acceptBidWon.json", { :projectid => 1 })
        @freelancer.accept_won_bid(:project_id => 1)

      end

      should "parse response into a status confirmation model" do

        stub_api_get("/Freelancer/acceptBidWon.json", "status_confirmation.json")
        status = @freelancer.accept_won_bid
        status.success?.should == true

      end

    end

    context "reject won project" do

      should "be able to reject project" do

        @freelancer.expects(:api_get).with("/Freelancer/acceptBidWon.json", { :projectid => 1, :state => 0 })
        @freelancer.reject_won_bid(:project_id => 1)

      end

      should "parse response into a status confirmation model" do

        stub_api_get("/Freelancer/acceptBidWon.json?state=0", "status_confirmation.json")
        status = @freelancer.reject_won_bid
        status.success?.should == true

      end

    end

  end

end
