class NotificationTest < Test::Unit::TestCase

  context "notification models" do

    should "create notification instances based on json" do

      notifications = Freelancer::Models::Notification.parse_collection(fixture_file("notification/get_notification.json"), :shift => [ :"json-result", :items, :notification ])
      notifications.size.should == 1
      notifications.first.description.should == "Test notification"
      notifications.first.url.should == "http://www.sandbox.freelancer.com/"

    end

  end
end
