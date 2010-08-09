require "test_helper"

class ClientTest < Test::Unit::TestCase

  context "client" do

    setup do
      @freelancer = Freelancer::Client.new("consumer_token", "consumer_secret")
      consumer = OAuth::Consumer.new("consumer_token", "consumer_secret", { :site => "http://api.sandbox.freelancer.com" })
      @freelancer.stubs(:consumer).returns(consumer)
      @freelancer.authorize_from_access("access_token", "access_secret")
    end

    should "raise an error when a service call returns an error" do

      stub_api_get("/Project/getProjectFees.json", "error.json")
      assert_raise Freelancer::FreelancerResponseError do
        @freelancer.project_fees
      end

    end

  end
  
end
