require "test_helper"

class ProfileApiTest < Test::Unit::TestCase

  context "profile api" do
    
    setup do
      
      @freelancer = Freelancer::Client.new("consumer_token", "consumer_secret")
      consumer = OAuth::Consumer.new("consumer_token", "consumer_secret", { :site => "http://api.sandbox.freelancer.com" })
      @freelancer.stubs(:consumer).returns(consumer)
      
      @freelancer.authorize_from_access("access_token", "access_secret")
      
    end
    
    should "retrieve account information for the current user" do

      stub_api_get("/Profile/getAccountDetails.json", "account_details.json")
      details = @freelancer.account_details
      
      details.username.should == "test"
      details.userid.should == "12345"
      details.fullname.should == "Test User"
      details.company_name.should == "Test Inc."
      details.type_of_work.should == "Both"
      details.picture_url.should == []
      details.addressline1.should == "Fictional Street"
      details.addressline2.should == ""
      details.city.should == "Somewhere"
      details.state.should == ""
      details.country.should == "Norway"
      details.postalcode.should == "0850"
      details.phone.should == "+4712345678"
      details.fax.should == ""
      details.notificationformat.should == "text/html"
      details.emailnotificationstatus.should == 0
      details.receivenewsstatus.should == "0"
      details.bidwonnotificationstatus.should == "1"
      details.bidplacednotificationstatus.should == "1"
      details.newprivatemessagestatus.should == "1"
      details.profiletext.should == ""
      details.vision.should == ""
      details.keywords.should == ""
      details.hourlyrate.should == "2"
      details.skills.should == ""
      
      details.qualifications.size.should == 4
      details.qualifications[0].should == "PHP"
      details.qualifications[1].should == "Perl"
      details.qualifications[2].should == "JSP"
      details.qualifications[3].should == "Ruby & Ruby on Rails"
      
      details.latest_open_projects.size.should == 0
      details.latest_closed_projects.size.should == 0
      details.latest_bids_on_projects.size.should == 0
      details.latest_won_projects.size.should == 0
      details.latest_lost_projects.size.should == 0
      
      details.latest_frozen_projects.size.should == 1
      details.latest_frozen_projects.first.id.should == 148
      details.latest_frozen_projects.first.name.should == "Test project to get some reviews on my account"
      details.latest_frozen_projects.first.url.should == "http://www.sandbox.freelancer.com/NET/Test-project-get-some-reviews.html.html"
      
    end
    
    should "update my account details" do
      
      account = Freelancer::Models::Account.new
      account.fullname = "Test User"
      
      stub_api_get("/Profile/setProfileInfo.json?fullname=Test%20User&qualificationcsv=", "set_profile_info.json")
      
      status = @freelancer.update_account_details(account)
      status.should == true
      
    end
    
    should "retrieve account information for another user" do

      stub_api_get("/Profile/getProfileInfo.json?userid=1", "profile_info.json")
      details = @freelancer.profile_info(1)
      
      details.username.should == "test"
      details.userid.should == "12345"
      details.profiletext.should == ""
      details.vision.should == ""
      details.keywords.should == ""
      details.hourlyrate.should == "2"

      details.qualifications.size.should == 1
      details.qualifications.first.should == ".NET"

      details.latest_open_projects.size.should == 0
      details.latest_closed_projects.size.should == 0
      details.latest_bids_on_projects.size.should == 1
      details.latest_won_projects.size.should == 0
      details.latest_lost_projects.size.should == 0
      details.latest_frozen_projects.size.should == 0
      
    end

  end

end
