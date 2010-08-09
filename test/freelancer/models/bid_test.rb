class BidTest < Test::Unit::TestCase

  context "bid model" do

    should "create bid list based on json" do

      bids = Freelancer::Models::Bid.parse_collection(fixture_file("project/get_bids_details.json"), :shift => [ :"json-result", :items ])
      bids.size.should == 1
      bids.first.provider.id.should == 123456
      bids.first.provider.username.should == "test-username"
      bids.first.provider_rating.should == 0
      bids.first.amount.should == 250
      bids.first.milestone.should == "-"
      bids.first.highlighted?.should == false
      bids.first.days.should == 1
      bids.first.description.should == "Test, ignore"
      bids.first.submitted_at.should == Date.parse("2010-08-09 12:28:57")
      bids.first.total_messages.should == 0
      bids.first.unread_messages.should == 0

    end

  end

end
