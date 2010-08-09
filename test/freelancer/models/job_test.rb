class JobTest < Test::Unit::TestCase

  context "job model" do

    should "create job list based on JSON" do

      jobs = Freelancer::Models::Job.parse_collection(fixture_file("job/get_job_list.json"), :shift => [ :"json-result", :items ])
      jobs.size.should == 325

      jobs.first.id.should == 15
      jobs.first.name.should == ".NET"
      jobs.first.project_count.should == 16
      jobs.first.seo_url.should == "NET"

    end

  end

end
