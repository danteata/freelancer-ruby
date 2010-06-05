require "test_helper"

class UserTest < Test::Unit::TestCase

  context "user model" do
    
    setup do
      @user_json = JSON.parse(fixture_file("user_details.json"), { :symbolize_names => true })[:user]
    end

    should "create a user based on JSON from API" do
      
      user = Freelancer::Models::User.from_json(@user_json)
      
      user.user_id.should == 1619837
      user.username.should == "binarymarbles"
      user.url.should == "http://www.sandbox.freelancer.com/users/1619837.html"
      user.registered_at_epoch.should == 1275687444
      user.registered_at_date.should == "Fri, 04 Jun 2010 17:37:24 -0400"
      user.company_name.should == "Binary Marbles"
      user.gold.should == 1
      user.hourly_rate.should == false
      
      user.country.should == "Norway"
      user.city.should == "Gjovik"
      
      user.avg_rating.should == "0"
      user.rating_count.should == 0
      user.avg_buyer_rating.should == "0"
      user.buyer_rating_count.should == 0
      user.avg_provider_rating.should == "0"
      user.provider_rating_count.should == 0
      
      user.jobs.should == ["JSP", "Perl", "PHP", "Ruby & Ruby on Rails"]
      
    end

    should "transform a user back into the same JSON structure it was built from" do
      
      user = Freelancer::Models::User.from_json(@user_json)
      generated_json = user.to_json
      regenerated_user = Freelancer::Models::User.from_json(generated_json)
      regenerated_json = regenerated_user.to_json
      
      generated_json.should == regenerated_json
      
    end
  
  end

end
