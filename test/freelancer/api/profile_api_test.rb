require "test_helper"

class ProfileApiTest < Test::Unit::TestCase

  context "profile api" do

    setup do
      @freelancer = Freelancer::Client.new("consumer_token", "consumer_secret")
      consumer = OAuth::Consumer.new("consumer_token", "consumer_secret", { :site => "http://api.sandbox.freelancer.com" })
      @freelancer.stubs(:consumer).returns(consumer)
      @freelancer.authorize_from_access("access_token", "access_secret")
    end

    context "account details" do

      should "be able to retrieve" do

        @freelancer.expects(:api_get).with("/Profile/getAccountDetails.json")
        @freelancer.account_details

      end

      should "parse response into a user" do

        stub_api_get("/Profile/getAccountDetails.json", "profile/get_account_details.json")
        account = @freelancer.account_details
        account.id.should == 123456

      end

    end

    context "profile info" do

      should "be able to retrieve" do

        @freelancer.expects(:api_get).with("/Profile/getProfileInfo.json", { :userid => 1 })
        @freelancer.profile_info(:user_id => 1)

      end
      
      should "parse response into a user" do

        stub_api_get("/Profile/getProfileInfo.json?userid=1", "profile/get_profile_info.json")
        profile = @freelancer.profile_info(:user_id => 1)
        profile.id.should == 123456

      end

    end

  end

end
