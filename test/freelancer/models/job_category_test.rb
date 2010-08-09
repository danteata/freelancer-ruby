class JobCategoryTest < Test::Unit::TestCase

  context "job category model" do

    should "create collection of categories based on JSON" do

      categories = Freelancer::Models::JobCategory.parse_collection(fixture_file("job/get_category_job_list.json"), :shift => [ :"json-result", :items, :category ])
      categories.size.should == 10
      categories.first.id.should == 1
      categories.first.name.should == "Websites, IT & Software"
      categories.first.jobs.size.should > 0

    end

  end
end
