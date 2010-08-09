require "test_helper"

class EmployerApiTest < Test::Unit::TestCase

  context "employer api" do

    setup do
      @freelancer = Freelancer::Client.new("consumer_token", "consumer_secret")
      consumer = OAuth::Consumer.new("consumer_token", "consumer_secret", { :site => "http://api.sandbox.freelancer.com" })
      @freelancer.stubs(:consumer).returns(consumer)
      @freelancer.authorize_from_access("access_token", "access_secret")
    end

    context "posted project list" do

      should "be able to retrieve" do

        @freelancer.expects(:api_get).with("/Employer/getPostedProjectList.json", {})
        @freelancer.posted_projects

      end

      should "be able to retrieve by status" do

        @freelancer.expects(:api_get).with("/Employer/getPostedProjectList.json", { :status => 1 })
        @freelancer.posted_projects(:status => 1)

      end

      should "be able to retrieve by user id" do

        @freelancer.expects(:api_get).with("/Employer/getPostedProjectList.json", { :userid => 1 })
        @freelancer.posted_projects(:user_id => 1)

      end

      should "be able to retrieve by project id" do

        @freelancer.expects(:api_get).with("/Employer/getPostedProjectList.json", { :projectid => 1 })
        @freelancer.posted_projects(:project_id => 1)

      end

      should "be able to retrieve by type" do

        @freelancer.expects(:api_get).with("/Employer/getPostedProjectList.json", { :projectoption => "trial" })
        @freelancer.posted_projects(:type => "trial")

      end

      should "remove type param if set to active" do

        @freelancer.expects(:api_get).with("/Employer/getPostedProjectList.json", {})
        @freelancer.posted_projects(:type => "active")

      end

      should "be able to change result count" do

        @freelancer.expects(:api_get).with("/Employer/getPostedProjectList.json", { :count => 10 })
        @freelancer.posted_projects(:count => 10)

      end

      should "be able to change result page" do

        @freelancer.expects(:api_get).with("/Employer/getPostedProjectList.json", { :page => 2 })
        @freelancer.posted_projects(:page => 2)

      end

      should "parse response into a collection of projects" do

        stub_api_get("/Employer/getPostedProjectList.json", "employer/get_posted_project_list.json")
        projects = @freelancer.posted_projects
        projects.size.should == 2
        projects.first.id.should == 279

      end

    end

    context "trial project eligibility" do

      should "be able to query" do

        @freelancer.expects(:api_get).with("/Employer/eligibleForTrialProject.json")
        @freelancer.eligible_for_trial_project?

      end

      should "parse response into a eligibility model" do

        stub_api_get("/Employer/eligibleForTrialProject.json", "employer/eligible_for_trial_project.json")
        eligibility = @freelancer.eligible_for_trial_project
        eligibility.eligible?.should == false
        eligibility.bonus_points.should == 0

      end

    end
    
  end

end
