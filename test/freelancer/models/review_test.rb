class ReviewTest < Test::Unit::TestCase

  context "review model" do

    should "create review instance based on JSON" do

      reviews = Freelancer::Models::Review.parse_collection(fixture_file("user/get_user_feedback.json"), :shift => [ :user, :totalreviews, :items ])
      reviews.size.should == 1

      reviews.first.reviewer_username.should == "test-username"
      reviews.first.reviewer_id.should == 123456
      reviews.first.project_name.should == "Test project name"
      reviews.first.project_id.should == 123
      reviews.first.winning_bid.should == 300
      reviews.first.reviewed_at.should == Date.parse("2010-05-24 07:23:18")
      reviews.first.rating.should == 9
      reviews.first.comment.should == "Test comment"
      reviews.first.reply.should == "Test reply"

    end

    should "create a list of reviews based on pending feedbacks" do

      reviews = Freelancer::Models::Review.parse_collection(fixture_file("common/get_pending_feedback.json"), :shift => [ :"json-result", :items ])
      reviews.size.should == 1
      reviews.first.project_id == 280
      reviews.first.user_id.should == 123456
      reviews.first.username.should == "test-username"
      reviews.first.rateable_until.should == Date.parse("2010-11-06 01:53:34")
      reviews.first.status.should == "Paid"

    end

  end

end
