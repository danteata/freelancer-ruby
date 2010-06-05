require "test_helper"

class AccountTest < Test::Unit::TestCase

  context "account model" do
    
    setup do
      @account_json = JSON.parse(fixture_file("account_details.json"), { :symbolize_names => true })[:"xml-result"]
    end

    should "create an account instance based on JSON from API" do
      
      account = Freelancer::Models::Account.from_json(@account_json)
      
      account.user_id.should == "1619837"
      account.username.should == "binarymarbles"
      account.full_name.should == "Trond Arve Nordheim"
      account.company_name.should == "Binary Marbles"
      account.type_of_work.should == "Both"
      account.picture_url.should == []
      
      account.address_line_1.should == "Test street"
      account.address_line_2.should == ""
      account.city.should == "Test city"
      account.state.should == ""
      account.country.should == "Norway"
      account.postal_code.should == "1234"
      
      account.phone.should == "+4712345678"
      account.fax.should == ""
      
      account.notification_format.should == "text/html"
      account.email_notification_status.should == 0
      account.receive_news_status.should == "0"
      account.bid_won_notification_status.should == "1"
      account.bid_placed_notification_status.should == "0"
      account.new_private_message_status.should == "1"
      
      account.qualifications.should == ["PHP", "Perl", "JSP", "Ruby & Ruby on Rails"]
      account.profile_text.should == "Sample profile text"
      account.vision.should == "Sample vision text"
      account.keywords.should == "Sample keyword text"
      account.skills.should == "Sample skill 1\nSample skill 2\nSample skill 3\nSample skill 4\n"
      account.hourly_rate.should == "20"
      
      account.latest_open_projects.should == []
      account.latest_closed_projects.should == []
      account.latest_frozen_projects.size.should == 1
      account.latest_frozen_projects.first.project_id.should == 148
      account.latest_frozen_projects.first.name.should == "Test project to get some reviews on my account"
      account.latest_frozen_projects.first.url.should == "http://www.sandbox.freelancer.com/NET/Test-project-get-some-reviews.html.html"
      account.latest_bids_on_projects.should == []
      account.latest_won_projects.should == []
      account.latest_lost_projects.should == []
      
    end
    
    should "transform an account back into the same JSON structure it was built from" do
      
      account = Freelancer::Models::Account.from_json(@account_json)
      generated_json = account.to_json
      regenerated_account = Freelancer::Models::Account.from_json(generated_json)
      regenerated_json = regenerated_account.to_json
      
      generated_json.should == regenerated_json
      
    end
    
  end

end
