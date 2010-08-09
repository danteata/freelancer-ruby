require "test_helper"

class CommonApiTest < Test::Unit::TestCase

  context "common api" do

    setup do
      @freelancer = Freelancer::Client.new("consumer_token", "consumer_secret")
      consumer = OAuth::Consumer.new("consumer_token", "consumer_secret", { :site => "http://api.sandbox.freelancer.com" })
      @freelancer.stubs(:consumer).returns(consumer)
      @freelancer.authorize_from_access("access_token", "access_secret")
    end

    context "pending feedback" do

      should "be able to retrieve" do

        @freelancer.expects(:api_get).with("/Common/getPendingFeedback.json", {})
        @freelancer.pending_feedback

      end

      should "be able to retrieve by type" do

        @freelancer.expects(:api_get).with("/Common/getPendingFeedback.json", { :type => "P" })
        @freelancer.pending_feedback(:type => "P")

      end

      should "parse response into a collection of projects" do

        stub_api_get("/Common/getPendingFeedback.json", "common/get_pending_feedback.json")
        projects = @freelancer.pending_feedback
        projects.size.should == 1
        projects.first.id.should == 280

      end

    end

    context "config version" do

      should "be able to retrieve" do

        @freelancer.expects(:api_get).with("/Common/getConfigVersion.json", { :function => "withdrawalfee" })
        @freelancer.config_version(:function => "withdrawalfee")

      end

      should "parse response into a config version model" do

        stub_api_get("/Common/getConfigVersion.json?function=withdrawalfee", "common/get_config_version.json")
        version = @freelancer.config_version(:function => "withdrawalfee")
        version.function.should == "withdrawalfee"
        version.version.should == 1

      end

    end

    context "terms" do

      should "be able to retrieve" do

        @freelancer.expects(:api_get).with("/Common/getTerms.json")
        @freelancer.terms

      end

      should "return the terms as a string" do

        stub_api_get("/Common/getTerms.json", "common/get_terms.json")
        terms = @freelancer.terms
        terms.should == "Test terms"

      end

    end

    context "request cancel project" do

      should "be able to send request" do

        @freelancer.expects(:api_get).with("/Common/requestCancelProject.json", { :projectid => 1, :selectedwinner => 1, :commenttext => "Test" })
        @freelancer.request_cancel_project(:project_id => 1, :selected_winner => 1, :comment => "Test")

      end

      should "parse response into a status confirmation model" do

        stub_api_get("/Common/requestCancelProject.json", "status_confirmation.json")
        status = @freelancer.request_cancel_project
        status.success?.should == true

      end

    end

    context "post feedback" do

      should "be able to push feedback to user id" do

        @freelancer.expects(:api_get).with("/Common/postFeedback.json", { :projectid => 1, :userid => 1, :feedbacktext => "Test", :rating => 5 })
        @freelancer.post_feedback(:project_id => 1, :user_id => 1, :comment => "Test", :rating => 5)

      end

      should "be able to push feedback to username" do

        @freelancer.expects(:api_get).with("/Common/postFeedback.json", { :projectid => 1, :username => "test", :feedbacktext => "Test", :rating => 5 })
        @freelancer.post_feedback(:project_id => 1, :username => "test", :comment => "Test", :rating => 5)

      end

      should "parse response into a status confirmation model" do

        stub_api_get("/Common/postFeedback.json", "status_confirmation.json")
        status = @freelancer.post_feedback
        status.success?.should == true

      end

    end

    context "post reply to feedback" do

      should "be able to push feedback reply to user id" do

        @freelancer.expects(:api_get).with("/Common/postReplyForFeedback.json", { :projectid => 1, :userid => 1, :feedbacktext => "Test" })
        @freelancer.post_feedback_reply(:project_id => 1, :user_id => 1, :comment => "Test")

      end

      should "be able to push feedback reply to username" do

        @freelancer.expects(:api_get).with("/Common/postReplyForFeedback.json", { :projectid => 1, :username => "test", :feedbacktext => "Test" })
        @freelancer.post_feedback_reply(:project_id => 1, :username => "test", :comment => "Test")

      end

      should "parse response into a status confirmation model" do

        stub_api_get("/Common/postReplyForFeedback.json", "status_confirmation.json")
        status = @freelancer.post_feedback_reply
        status.success?.should == true

      end

    end

    context "request withdraw feedback" do

      should "be able to push request by user id" do

        @freelancer.expects(:api_get).with("/Common/requestWithdrawFeedback.json", { :projectid => 1, :userid => 1 })
        @freelancer.request_withdraw_feedback(:project_id => 1, :user_id => 1)

      end

      should "be able to push request by username" do

        @freelancer.expects(:api_get).with("/Common/requestWithdrawFeedback.json", { :projectid => 1, :username => "test" })
        @freelancer.request_withdraw_feedback(:project_id => 1, :username => "test")

      end

      should "parse response into a status confirmation model" do

        stub_api_get("/Common/requestWithdrawFeedback.json", "status_confirmation.json")
        status = @freelancer.request_withdraw_feedback
        status.success?.should == true

      end

    end

  end

end
