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
    
    context "post new project" do

      setup do

        @project = Freelancer::Models::Project.new
        @project.jobs = [ "Ruby", ".NET" ]
        @project.budget_option = 1
        @project.options = Freelancer::Models::ProjectOptions.new

        @expected_params = {
          :duration => nil,
          :budgetoption => 1,
          :projectname => nil,
          :jobtypecsv => 'Ruby,.NET',
          :projectdesc => nil
        }

        @expected_query_string = "budgetoption=1&projectname=&jobtypecsv=Ruby,.NET&projectdesc=&duration="

      end

      should "be able to push project" do

        @freelancer.expects(:api_get).with("/Employer/postNewProject.json", @expected_params)
        @freelancer.new_project(@project)

      end

      should "parse response into a project model" do

        stub_api_get("/Employer/postNewProject.json?#{@expected_query_string}", "employer/post_new_project.json")
        project = @freelancer.new_project(@project)
        project.id.should > 0
        project.url.length.should > 0
        project.posted_at.should_not == nil

      end

    end

    context "post new draft project" do

      setup do

        @project = Freelancer::Models::Project.new
        @project.jobs = [ "Ruby", ".NET" ]
        @project.budget_option = 1
        @project.options = Freelancer::Models::ProjectOptions.new

        @expected_params = {
          :duration => nil,
          :budgetoption => 1,
          :projectname => nil,
          :jobtypecsv => 'Ruby,.NET',
          :projectdesc => nil
        }

        @expected_query_string = "budgetoption=1&projectname=&jobtypecsv=Ruby,.NET&projectdesc=&duration="

      end

      should "be able to push project" do

        @freelancer.expects(:api_get).with("/Employer/postNewDraftProject.json", @expected_params)
        @freelancer.new_project_draft(@project)

      end

      should "parse response into a project model" do

        stub_api_get("/Employer/postNewDraftProject.json?#{@expected_query_string}", "employer/post_new_draft_project.json")
        project = @freelancer.new_project_draft(@project)
        project.id.should > 0
        project.url.length.should > 0
        project.posted_at.should_not == nil

      end

    end

    context "post new trial project" do

      setup do

        @project = Freelancer::Models::Project.new
        @project.jobs = [ "Ruby", ".NET" ]
        @project.budget_option = 1
        @project.options = Freelancer::Models::ProjectOptions.new

        @expected_params = {
          :duration => nil,
          :budgetoption => 1,
          :projectname => nil,
          :jobtypecsv => 'Ruby,.NET',
          :projectdesc => nil
        }

        @expected_query_string = "budgetoption=1&projectname=&jobtypecsv=Ruby,.NET&projectdesc=&duration="

      end

      should "be able to push project" do

        @freelancer.expects(:api_get).with("/Employer/postNewTrialProject.json", @expected_params)
        @freelancer.new_trial_project(@project)

      end

      should "parse response into a project model" do

        stub_api_get("/Employer/postNewTrialProject.json?#{@expected_query_string}", "employer/post_new_trial_project.json")
        project = @freelancer.new_trial_project(@project)
        project.id.should > 0
        project.url.length.should > 0
        project.posted_at.should_not == nil

      end

    end

    context "update project details" do

      setup do

        @project = Freelancer::Models::Project.new
        @project.jobs = [ "Ruby", ".NET" ]

        @expected_params = {
          :projectid => nil,
          :jobtypecsv => 'Ruby,.NET',
          :projectdesc => nil
        }

        @expected_query_string = "projectid=&jobtypecsv=Ruby,.NET&projectdesc="

      end

      should "be able to push update" do

        @freelancer.expects(:api_get).with("/Employer/updateProjectDetails.json", @expected_params)
        @freelancer.update_project(@project)

      end

      should "parse response into a status confirmation model" do

        stub_api_get("/Employer/updateProjectDetails.json?#{@expected_query_string}", "status_confirmation.json")
        status = @freelancer.update_project(@project)
        status.success?.should == true

      end

    end

    context "choose winner for project" do

      should "be able to choose a winner" do

        @freelancer.expects(:api_get).with("/Employer/chooseWinnerForProject.json", { :projectid => 1, :useridcsv => "1" })
        @freelancer.choose_winner_for_project(:project_id => 1, :user_id => 1)

      end

      should "be able to choose multiple winners" do

        @freelancer.expects(:api_get).with("/Employer/chooseWinnerForProject.json", { :projectid => 1, :useridcsv => "1,2,3" })
        @freelancer.choose_winner_for_project(:project_id => 1, :user_id => [ 1, 2, 3 ])

      end

      should "parse response into a status confirmation model" do

        stub_api_get("/Employer/chooseWinnerForProject.json?projectid=1&useridcsv=1", "status_confirmation.json")
        status = @freelancer.choose_winner_for_project(:project_id => 1, :user_id => 1)
        status.success?.should == true

      end

    end

    context "invite user to project" do

      should "be able to invite a user by user id" do

        @freelancer.expects(:api_get).with("/Employer/inviteUserForProject.json", { :projectid => 1, :useridcsv => "1" })
        @freelancer.invite_user_to_project(:project_id => 1, :user_id => 1)

      end

      should "be able to invite multiple users by user id" do

        @freelancer.expects(:api_get).with("/Employer/inviteUserForProject.json", { :projectid => 1, :useridcsv => "1,2,3" })
        @freelancer.invite_user_to_project(:project_id => 1, :user_id => [ 1, 2, 3 ])

      end

      should "be able to invite a user by username" do

        @freelancer.expects(:api_get).with("/Employer/inviteUserForProject.json", { :projectid => 1, :usernamecsv => "test" })
        @freelancer.invite_user_to_project(:project_id => 1, :username => "test")

      end

      should "be able to invite multiple users by username" do

        @freelancer.expects(:api_get).with("/Employer/inviteUserForProject.json", { :projectid => 1, :usernamecsv => "test,user" })
        @freelancer.invite_user_to_project(:project_id => 1, :username => [ "test", "user" ])

      end

      should "parse response into a status confirmation model" do

        stub_api_get("/Employer/inviteUserForProject.json?projectid=1&useridcsv=1", "status_confirmation.json")
        status = @freelancer.invite_user_to_project(:project_id => 1, :user_id => 1)
        status.success?.should == true

      end

    end

    context "upgrade a trial project" do

      should "be able to push update" do

        @freelancer.expects(:api_get).with("/Employer/upgradeTrialProject.json", { :projectid => 1 })
        @freelancer.upgrade_trial_project(:project_id => 1)

      end

      should "parse response into a status confirmation model" do

        stub_api_get("/Employer/upgradeTrialProject.json?projectid=1", "status_confirmation.json")
        status = @freelancer.upgrade_trial_project(:project_id => 1)
        status.success?.should == true

      end

    end

    context "delete a draft project" do

      should "be able to push update" do

        @freelancer.expects(:api_get).with("/Employer/deleteDraftProject.json", { :projectid => 1 })
        @freelancer.delete_draft_project(:project_id => 1)

      end

      should "parse response into a status confirmation model" do

        stub_api_get("/Employer/deleteDraftProject.json?projectid=1", "status_confirmation.json")
        status = @freelancer.delete_draft_project(:project_id => 1)
        status.success?.should == true

      end

    end

  end

end
