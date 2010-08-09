class EligibilityTest < Test::Unit::TestCase

  context "eligibility model" do

    should "create eligibility instance based on JSON" do

      eligibility = Freelancer::Models::Eligibility.parse(fixture_file("employer/eligible_for_trial_project.json"), :shift => :"json-result")
      eligibility.eligible.should == false
      eligibility.bonus_points.should == 0

    end

  end
end
