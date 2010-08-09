class UserTest < Test::Unit::TestCase

  context "user model" do

    should "create user instance based on JSON" do

      user = Freelancer::Models::User.parse(fixture_file("user/get_user_details.json"), :shift => :user)
      user.id.should == 123456
      user.username.should == "test-user"
      user.url.should == "http://www.sandbox.freelancer.com/users/123456.html"
      user.logo_url.should == "false"
      user.profile_logo_url.should == "../../img/unknown.png"
      user.registered_at.should == Date.parse("Fri, 04 Jun 2010 17:37:24 -0400")
      user.company.should == "Test Company"
      user.hourly_rate.should == 20
      user.job_types.should == [ "JSP", "Perl", "PHP", "Ruby &amp; Ruby on Rails" ]
      user.gold_status.should == true

      user.address.country.should == "Norway"
      user.address.city.should == "Oslo"

      user.rating.average.should == 0
      user.rating.count.should == 0

      user.provider_rating.average.should == 0
      user.provider_rating.count.should == 0

      user.buyer_rating.average.should == 0
      user.buyer_rating.count.should == 0

    end

    should "create collection of users based on search result" do

      users = Freelancer::Models::User.parse_collection(fixture_file("user/get_users_by_search.json"), :shift => [ :"json-result", :items ])
      users.size.should == 1

      users.first.id.should == 123456
      users.first.username.should == "test-username"
      users.first.company.should == nil
      users.first.address.country.should == nil
      users.first.address.city.should == nil
      users.first.average_pricing.should == nil

    end

    should "create profile instance based on JSON" do

      user = Freelancer::Models::User.parse(fixture_file("profile/get_account_details.json"), :shift => :"json-result")

      user.username.should == "test-username"
      user.id.should == 123456
      user.name.should == "Test User"
      user.company.should == "Test Company"
      user.type_of_work.should == "Both"
      user.picture_url.should == nil
      user.phone_number.should == "4712345678"
      user.fax_number.should == ""
      user.profile_text.should == "Sample profile text"
      user.vision.should == "Sample vision text"
      user.keywords.should == "Sample keyword text"
      user.hourly_rate.should == 20
      user.skills.should == [ "Sample skill 1", "Sample skill 2", "Sample skill 3", "Sample skill 4" ]
      user.qualifications.should == [ "PHP", "Perl", "JSP", "Ruby &amp; Ruby on Rails" ]

      user.address.street_name.should == "Some Street"
      user.address.street_name_2.should == ""
      user.address.city.should == "Oslo"
      user.address.state.should == ""
      user.address.country.should == "Norway"
      user.address.postal_code.should == "0123"

      user.notifications.notification_format.should == "text/html"
      user.notifications.email.should == false
      user.notifications.news.should == false
      user.notifications.bid_won.should == true
      user.notifications.bid_placed.should == false
      user.notifications.new_private_message.should == true

      user.open_buyer_projects.size.should == 0
      user.closed_buyer_projects.size.should == 0
      user.frozen_buyer_projects.size.should == 1
      user.bid_seller_projects.size.should == 0
      user.won_seller_projects.size.should == 0
      user.lost_seller_projects.size.should == 0
      user.frozen_buyer_projects.first.id.should == 123
      user.frozen_buyer_projects.first.name.should == "Test project"
      user.frozen_buyer_projects.first.url.should == "http://www.sandbox.freelancer.com/NET/Test-project.html"

    end

  end

end
