require "test_helper"

class NotificationApiTest < Test::Unit::TestCase

  context "notification api" do

    setup do
      @freelancer = Freelancer::Client.new("consumer_token", "consumer_secret")
      consumer = OAuth::Consumer.new("consumer_token", "consumer_secret", { :site => "http://api.sandbox.freelancer.com" })
      @freelancer.stubs(:consumer).returns(consumer)
      @freelancer.authorize_from_access("access_token", "access_secret")
    end

    context "notification list" do

      should "be able to retrieve" do

        @freelancer.expects(:api_get).with("/Notification/getNotification.json")
        @freelancer.notifications

      end

      should "parse response into a collection of notifications" do

        stub_api_get("/Notification/getNotification.json", "notification/get_notification.json")
        notifications = @freelancer.notifications
        notifications.size.should == 1
        notifications.first.description.should == "Test notification"

      end

    end

    context "news list" do

      should "be able to retrieve" do

        @freelancer.expects(:api_get).with("/Notification/getNews.json")
        @freelancer.news

      end

      should "parse response into a collection of news" do

        stub_api_get("/Notification/getNews.json", "notification/get_news.json")
        news = @freelancer.news
        news.size.should == 8
        news.first.id.should == 177

      end

    end

  end

end
