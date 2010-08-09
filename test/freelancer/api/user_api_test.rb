require "test_helper"

class UserApiTest < Test::Unit::TestCase

  context "user api" do

    setup do
      @freelancer = Freelancer::Client.new("consumer_token", "consumer_secret")
      consumer = OAuth::Consumer.new("consumer_token", "consumer_secret", { :site => "http://api.sandbox.freelancer.com" })
      @freelancer.stubs(:consumer).returns(consumer)
      @freelancer.authorize_from_access("access_token", "access_secret")
    end

    context "user search" do

      should "be able to search" do

        @freelancer.expects(:api_get).with("/User/getUsersBySearch.json", {})
        @freelancer.user_search

      end

      should "be able to search by username" do

        @freelancer.expects(:api_get).with("/User/getUsersBySearch.json", { :username => "test" })
        @freelancer.user_search(:username => "test")

      end

      should "be able to search by one expertise" do

        @freelancer.expects(:api_get).with("/User/getUsersBySearch.json", { :expertise_csv => "Ruby" })
        @freelancer.user_search(:expertise => "Ruby")

      end

      should "be able to search by several expertises" do

        @freelancer.expects(:api_get).with("/User/getUsersBySearch.json", { :expertise_csv => "Ruby,.NET" })
        @freelancer.user_search(:expertise => [ "Ruby", ".NET" ])

      end


      should "be able to search by one country" do

        @freelancer.expects(:api_get).with("/User/getUsersBySearch.json", { :country_csv => "Norway" })
        @freelancer.user_search(:country => "Norway")

      end

      should "be able to search by several countries" do

        @freelancer.expects(:api_get).with("/User/getUsersBySearch.json", { :country_csv => "Norway,Australia" })
        @freelancer.user_search(:country => [ "Norway", "Australia" ])

      end

      should "be able to search by rating" do

        @freelancer.expects(:api_get).with("/User/getUsersBySearch.json", { :rating => 3 })
        @freelancer.user_search(:rating => 3)

      end

      should "be able to change result count" do

        @freelancer.expects(:api_get).with("/User/getUsersBySearch.json", { :count => 10 })
        @freelancer.user_search(:count => 10)

      end

      should "be able to change result page" do

        @freelancer.expects(:api_get).with("/User/getUsersBySearch.json", { :page => 2 })
        @freelancer.user_search(:page => 2)

      end

      should "parse response into a collection of users" do

        stub_api_get("/User/getUsersBySearch.json", "user/get_users_by_search.json")
        users = @freelancer.user_search
        users.size.should == 1
        users.first.id.should == 123456

      end

    end

    context "user feedback" do

      should "be able to list by username" do

        @freelancer.expects(:api_get).with("/User/getUserFeedback.json", { :username => "test" })
        @freelancer.user_feedback(:username => "test")
 
      end

      should "be able to list by user id" do

        @freelancer.expects(:api_get).with("/User/getUserFeedback.json", { :userid => 1 })
        @freelancer.user_feedback(:user_id => 1)

      end

      should "be able to list by type" do

        @freelancer.expects(:api_get).with("/User/getUserFeedback.json", { :type => "P" })
        @freelancer.user_feedback(:type => "P")

      end

      should "parse response into a collection of feedbacks" do

        stub_api_get("/User/getUserFeedback.json", "user/get_user_feedback.json")
        feedbacks = @freelancer.user_feedback
        feedbacks.size.should == 1
        feedbacks.first.project_id.should == 123

      end

    end

    context "user details" do

      should "be able to retrieve by username" do

        @freelancer.expects(:api_get).with("/User/getUserDetails.json", { :username => "test" })
        @freelancer.user_details(:username => "test")

      end

      should "be able to retrieve by user id" do

        @freelancer.expects(:api_get).with("/User/getUserDetails.json", { :userid => 1 })
        @freelancer.user_details(:user_id => 1)

      end

      should "parse response into a user model" do

        stub_api_get("/User/getUserDetails.json", "user/get_user_details.json")
        user = @freelancer.user_details
        user.id.should == 123456

      end

    end

  end

end
