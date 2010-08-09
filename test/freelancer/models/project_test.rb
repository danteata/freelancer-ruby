class ProjectTest < Test::Unit::TestCase

  context "project model" do

    should "create project instances based on posted project list" do

      projects = Freelancer::Models::Project.parse_collection(fixture_file("employer/get_posted_project_list.json"), :shift => [ :"json-result", :items ])
      projects.size.should == 2
      projects.first.id.should == 279
      projects.first.name.should == "Test project name"

    end

    should "create project instances basd on bid project list" do

      projects = Freelancer::Models::Project.parse_collection(fixture_file("freelancer/get_project_list_for_placed_bids.json"), :shift => [ :"json-result", :items ])
      projects.size.should == 1
      projects.first.id.should == 191
      projects.first.name.should == "Project for testing"
      projects.first.url.should == "http://www.sandbox.freelancer.com/projects/PHP-NET/Project-for-testing.html"
      projects.first.bids.should == 1
      projects.first.average_bid.should == 250
      projects.first.status.should == "A"
      projects.first.additional_status.should == "Open"
      projects.first.ends_at.should == Date.parse("2010-07-18 00:07:43")

    end

    should "create project instances based on project list for transfer" do

      projects = Freelancer::Models::Project.parse_collection(fixture_file("payment/get_project_list_for_transfer.json"), :shift => [ :"json-result", :items, :project ])
      projects.size.should == 1
      projects.first.id.should == 148
      projects.first.name.should == "Test project to get some reviews on my account"
      projects.first.selected_freelancers.size.should == 1
      projects.first.selected_freelancers.first.id.should == 123456
      projects.first.selected_freelancers.first.username.should == "test-username"
      projects.first.selected_freelancers.first.bid_amount.should == 500
      projects.first.selected_freelancers.first.paid_amount.should == 500

    end

    should "create project instances based on search result" do

      projects = Freelancer::Models::Project.parse_collection(fixture_file("project/search_projects.json"), :shift => [ :"json-result", :items ])
      projects.size.should == 2
      projects.first.id.should == 150
      projects.first.name.should == "Test Freelancer API2"
      projects.first.bids.should == 0
      projects.first.average_bid.should == nil
      projects.first.jobs.should == [ ".NET" ]
      projects.first.starts_at.should == Date.parse("2010-06-06 19:08:32")
      projects.first.time_left.should == "-3 days and -4 hours"
      projects.first.url.should == "http://www.sandbox.freelancer.com/projects/150.html"

    end

    should "create project instance based json" do

      project = Freelancer::Models::Project.parse(fixture_file("project/get_project_details.json"), :shift => [ :"json-result" ])
      project.id.should == 280
      project.name.should == "Test project"
      project.url.should == "http://www.sandbox.freelancer.com/projects/PHP-NET/Test-project.html"
      project.starts_at.should == Date.parse("2010-08-07 21:51:06")
      project.ends_at.should == Date.parse("2010-08-12 21:51:06")
      
      project.buyer.id.should == 123456
      project.buyer.username.should == "test-username"
      project.buyer.url.should == "http://www.sandbox.freelancer.com/users/123456.html"
      
      project.status.should == "C"
      project.short_description.should == "This is just a test project."

      project.options.featured?.should == false
      project.options.non_public?.should == false
      project.options.trial?.should == false
      project.options.full_time?.should == false
      project.options.gold_members_only?.should == true
      project.options.hidden_bids?.should == false

      project.minimum_budget.should == 250
      project.maximum_budget.should == 750

      project.jobs.should == [ ".NET", "PHP" ]

      project.bids.should == 1
      project.average_bid.should == 250

      project.sellers.size.should == 1
      project.sellers.first.id.should == 123456
      project.sellers.first.username.should == "test-username"
      project.sellers.first.award_status.should == "awarded"

    end

  end
end
