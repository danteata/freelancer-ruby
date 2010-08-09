require "test_helper"

class JobApiTest < Test::Unit::TestCase

  context "job api" do

    setup do
      @freelancer = Freelancer::Client.new("consumer_token", "consumer_secret")
      consumer = OAuth::Consumer.new("consumer_token", "consumer_secret", { :site => "http://api.sandbox.freelancer.com" })
      @freelancer.stubs(:consumer).returns(consumer)
      @freelancer.authorize_from_access("access_token", "access_secret")
    end

    context "job list" do

      should "be able to retrieve" do

        @freelancer.expects(:api_get).with("/Job/getJobList.json")
        @freelancer.jobs

      end

      should "parse response into a collection of jobs" do

        stub_api_get("/Job/getJobList.json", "job/get_job_list.json")
        jobs = @freelancer.jobs
        jobs.size.should == 325
        jobs.first.id == 15

      end

    end

    context "job category list" do

      should "be able to retrieve" do

        @freelancer.expects(:api_get).with("/Job/getCategoryJobList.json")
        @freelancer.job_categories

      end

      should "parse response into a collection of categories" do

        stub_api_get("/Job/getCategoryJobList.json", "job/get_category_job_list.json")
        categories = @freelancer.job_categories
        categories.size.should == 10
        categories.first.id.should == 1

      end

    end

    context "my job list" do

      should "be able to retrieve" do

        @freelancer.expects(:api_get).with("/Job/getMyJobList.json")
        @freelancer.my_jobs

      end

      should "parse response into a collection of jobs" do

        stub_api_get("/Job/getMyJobList.json", "job/get_my_job_list.json")
        jobs = @freelancer.my_jobs
        jobs.size.should == 4
        jobs.first.id.should == 3

      end

    end

  end

end
