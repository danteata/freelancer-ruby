class MessageTest < Test::Unit::TestCase

  context "message model" do

    should "create message instances based on json" do

      messages = Freelancer::Models::Message.parse_collection(fixture_file("project/get_public_messages.json"), :shift => [ :"json-result", :items ])
      messages.size.should == 1
      messages.first.user.id.should == 123456
      messages.first.user.username.should == "test-username"
      messages.first.sent_at.should == Date.parse("2010-08-08 02:14:57")
      messages.first.text.should == "Test"
      messages.first.attachment_url.should == nil

    end

    should "create messages based on sent messages json" do

      messages = Freelancer::Models::Message.parse_collection(fixture_file("message/get_sent_messages.json"), :shift => [ :"json-result", :items ])
      messages.size.should == 2 
      messages.first.project_id.should == 281
      messages.first.user.id.should == 123456
      messages.first.user.username.should == "test-username"
      messages.first.text.should == "Test"

    end


    should "create messages based on inbox messages" do

      messages = Freelancer::Models::Message.parse_collection(fixture_file("message/get_inbox_messages.json"), :shift => [ :"json-result", :items ])
      messages.size.should == 1
      messages.first.id.should == 203
      messages.first.project_id.should == 281
      messages.first.user.username.should == "test-username"
      messages.first.text.should == "Test"
      messages.first.new?.should == true

    end

  end
end
