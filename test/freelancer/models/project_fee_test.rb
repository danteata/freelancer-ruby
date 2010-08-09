class ProjectFeeTest < Test::Unit::TestCase

  context "project fee model" do

    should "create list of project fee instances based on json" do

      fees = Freelancer::Models::ProjectFee.parse_collection(fixture_file("project/get_project_fees.json"), :shift => [ :"json-result", :items ])
      fees.size.should == 5
      fees.first.project_type.should == "featured_create"
      fees.first.project_description.size.should > 10
      fees.first.fee.should == 19

    end

  end

end
