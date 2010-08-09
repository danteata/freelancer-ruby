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

  end

end
