require "test_helper"

class MessageApiTest < Test::Unit::TestCase

  context "message api" do

    setup do
      @freelancer = Freelancer::Client.new("consumer_token", "consumer_secret")
      consumer = OAuth::Consumer.new("consumer_token", "consumer_secret", { :site => "http://api.sandbox.freelancer.com" })
      @freelancer.stubs(:consumer).returns(consumer)
      @freelancer.authorize_from_access("access_token", "access_secret")
    end

    context "inbox messages" do

      should "be able to list" do

        @freelancer.expects(:api_get).with("/Message/getInboxMessages.json", {})
        @freelancer.messages

      end

      should "be able to list by project id" do

        @freelancer.expects(:api_get).with("/Message/getInboxMessages.json", { :projectid => 1 })
        @freelancer.messages(:project_id => 1)

      end

      should "be able to change result count" do

        @freelancer.expects(:api_get).with("/Message/getInboxMessages.json", { :count => 20 })
        @freelancer.messages(:count => 20)

      end

      should "be able to change result page" do

        @freelancer.expects(:api_get).with("/Message/getInboxMessages.json", { :page => 2 })
        @freelancer.messages(:page => 2)

      end

      should "parse response into a collection of messages" do

        stub_api_get("/Message/getInboxMessages.json", "message/get_inbox_messages.json")
        messages = @freelancer.messages
        messages.size.should == 1
        messages.first.id.should == 203

      end

    end

    context "sent messages" do

      should "be able to list" do

        @freelancer.expects(:api_get).with("/Message/getSentMessages.json", {})
        @freelancer.sent_messages

      end

      should "be able to change result count" do

        @freelancer.expects(:api_get).with("/Message/getSentMessages.json", { :count => 20 })
        @freelancer.sent_messages(:count => 20)

      end

      should "be able to change result page" do

        @freelancer.expects(:api_get).with("/Message/getSentMessages.json", { :page => 2 })
        @freelancer.sent_messages(:page => 2)

      end

      should "parse response into a collection of messages" do

        stub_api_get("/Message/getSentMessages.json", "message/get_sent_messages.json")
        messages = @freelancer.sent_messages
        messages.size.should == 2
        messages.first.project_id.should == 281

      end

    end

    context "unread count" do

      should "be able to retrieve" do

        @freelancer.expects(:api_get).with("/Message/getUnreadCount.json")
        @freelancer.unread_message_count

      end

      should "return a number" do

        stub_api_get("/Message/getUnreadCount.json", "message/get_unread_count.json")
        count = @freelancer.unread_message_count
        count.should == 1

      end

    end

    context "message thread" do

      should "be able to retrieve" do

        @freelancer.expects(:api_get).with("/Message/loadMessageThread.json", { :projectid => 1, :betweenuserid => 1 })
        @freelancer.message_thread(:project_id => 1, :between_user_id => 1)

      end

      should "be able to change result count" do

        @freelancer.expects(:api_get).with("/Message/loadMessageThread.json", { :count => 20 })
        @freelancer.message_thread(:count => 20)

      end

      should "be able to change result page" do

        @freelancer.expects(:api_get).with("/Message/loadMessageThread.json", { :page => 2 })
        @freelancer.message_thread(:page => 2)

      end

      should "parse response into a collection of messages" do

        stub_api_get("/Message/loadMessageThread.json", "message/load_message_thread.json")
        messages = @freelancer.message_thread
        messages.size.should == 3
        messages.first.id.should == 203

      end

    end

  end

end
