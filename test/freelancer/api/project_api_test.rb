require "test_helper"

class ProjectApiTest < Test::Unit::TestCase

  context "project api" do

    setup do
      @freelancer = Freelancer::Client.new("consumer_token", "consumer_secret")
      consumer = OAuth::Consumer.new("consumer_token", "consumer_secret", { :site => "http://api.sandbox.freelancer.com" })
      @freelancer.stubs(:consumer).returns(consumer)
      @freelancer.authorize_from_access("access_token", "access_secret")
    end

    context "search projects" do

      should "be able to search" do

        @freelancer.expects(:api_get).with("/Project/searchProjects.json", {})
        @freelancer.project_search

      end

      should "be able to search by featured" do

        @freelancer.expects(:api_get).with("/Project/searchProjects.json", { :isfeatured => true })
        @freelancer.project_search(:featured => true)

      end

      should "be able to search by non-public" do

        @freelancer.expects(:api_get).with("/Project/searchProjects.json", { :isnonpublic => true })
        @freelancer.project_search(:non_public => true)

      end

      should "be able to search by keyword" do

        @freelancer.expects(:api_get).with("/Project/searchProjects.json", { :searchkeyword => "test" })
        @freelancer.project_search(:keyword => "test")

      end

      should "be able to search by one job" do

        @freelancer.expects(:api_get).with("/Project/searchProjects.json", { :searchjobtypecsv => "Ruby" })
        @freelancer.project_search(:job => "Ruby")

      end

      should "be able to search by several jobs" do

        @freelancer.expects(:api_get).with("/Project/searchProjects.json", { :searchjobtypecsv => "Ruby,.NET" })
        @freelancer.project_search(:job => [ "Ruby", ".NET" ])

      end

      should "be able to search by status" do

        @freelancer.expects(:api_get).with("/Project/searchProjects.json", { :status => "Closed" })
        @freelancer.project_search(:status => "Closed")

      end

      should "be able to search by minimum budget" do

        @freelancer.expects(:api_get).with("/Project/searchProjects.json", { :budgetmin => 250 })
        @freelancer.project_search(:minimum_budget => 250)

      end

      should "be able to search by maximum budget" do

        @freelancer.expects(:api_get).with("/Project/searchProjects.json", { :budgetmax => 100 })
        @freelancer.project_search(:maximum_budget => 100)

      end

      should "be able to search by full time projects" do

        @freelancer.expects(:api_get).with("/Project/searchProjects.json", { :isfulltime => true })
        @freelancer.project_search(:full_time => true)

      end

      should "be able to search by trial projects" do

        @freelancer.expects(:api_get).with("/Project/searchProjects.json", { :istrial => true })
        @freelancer.project_search(:trial => true)

      end

      should "be able to search by gold members only-projects" do

        @freelancer.expects(:api_get).with("/Project/searchProjects.json", { :isgoldmembersonly => true })
        @freelancer.project_search(:gold_members_only => true)

      end

      should "be able to change result count" do

        @freelancer.expects(:api_get).with("/Project/searchProjects.json", { :count => 20 })
        @freelancer.project_search(:count => 20)

      end

      should "be able to change result page" do

        @freelancer.expects(:api_get).with("/Project/searchProjects.json", { :page => 2 })
        @freelancer.project_search(:page => 2)

      end

      should "parse response into a collection of projects" do

        stub_api_get("/Project/searchProjects.json", "project/search_projects.json")
        projects = @freelancer.project_search
        projects.size.should == 2
        projects.first.id.should == 150

      end

    end

    context "project fees" do

      should "be able to retrieve" do

        @freelancer.expects(:api_get).with("/Project/getProjectFees.json")
        @freelancer.project_fees

      end

      should "parse response into a collection of project fees" do

        stub_api_get("/Project/getProjectFees.json", "project/get_project_fees.json")
        fees = @freelancer.project_fees
        fees.size.should == 5
        fees.first.project_type.should == "featured_create"

      end

    end

    context "project details" do

      should "be able to retrieve" do

        @freelancer.expects(:api_get).with("/Project/getProjectDetails.json", { :projectid => 1 })
        @freelancer.project_details(:project_id => 1)

      end


      should "parse response into a project model" do

        stub_api_get("/Project/getProjectDetails.json", "project/get_project_details.json")
        project = @freelancer.project_details
        project.id.should == 280

      end

    end


    context "bid details" do

      should "be able to retrieve" do

        @freelancer.expects(:api_get).with("/Project/getBidsDetails.json", { :projectid => 1 })
        @freelancer.project_bids(:project_id => 1)

      end

      should "parse response into a collection of bids" do

        stub_api_get("/Project/getBidsDetails.json", "project/get_bids_details.json")
        bids = @freelancer.project_bids
        bids.size.should == 1
        bids.first.amount.should == 250

      end

    end


    context "public messages" do

      should "be able to retrieve" do

        @freelancer.expects(:api_get).with("/Project/getPublicMessages.json", { :projectid => 1 })
        @freelancer.public_messages(:project_id => 1)

      end

      should "parse response into a collection of messages" do

        stub_api_get("/Project/getPublicMessages.json", "project/get_public_messages.json")
        messages = @freelancer.public_messages
        messages.size.should == 1
        messages.first.text.should == "Test"

      end

    end

    context "project budgets" do

      should "be able to retrieve" do

        @freelancer.expects(:api_get).with("/Project/getProjectBudgetConfig.json")
        @freelancer.project_budgets

      end

      should "parse respones into a collection of project budgets" do

        stub_api_get("/Project/getProjectBudgetConfig.json", "project/get_project_budget_config.json")
        budgets = @freelancer.project_budgets
        budgets.size.should == 6
        budgets.first.id.should == 5

      end

    end

  end

end
