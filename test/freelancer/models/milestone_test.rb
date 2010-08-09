class MilestoneTest < Test::Unit::TestCase

  context "milestone model" do

    should "create milestone instances based on account milestones" do

      milestones = Freelancer::Models::Milestone.parse_collection(fixture_file("payment/get_account_milestone_list.json"), :shift => [ :"json-result", :items ])
      milestones.size.should == 1
      milestones.first.id.should == 988
      milestones.first.username.should == "test-username"
      milestones.first.user_id.should == 123456
      milestones.first.made_at.should == Date.parse("2010-08-08 02:00:42")
      milestones.first.project_id.should == 148
      milestones.first.project_name.should == "Test project to get some reviews on my account"
      milestones.first.description.should == "Full payment for completed project"
      milestones.first.amount.should == 25

    end

  end
end
