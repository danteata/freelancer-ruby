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
      details.username.should == "binarymarbles"
      
    end
    
    should "update my account details" do
      
      account = Freelancer::Models::Account.new
      account.full_name = "Test User"
      
      stub_api_get("/Profile/setProfileInfo.json?lostSellerProjectList=&frozenBuyerProjectList=&emailnotificationstatus=&bidSellerProjectList=&profiletext=&city=&state=&fullname=Test%20User&receivenewsstatus=&company_name=&addressline1=&country=&vision=&openBuyerProjectList=&bidwonnotificationstatus=&type_of_work=&username=&keywords=&skills=&addressline2=&bidplacednotificationstatus=&picture_url=&wonSellerProjectList=&phone=&hourlyrate=&postalcode=&closeBuyerProjectList=&newprivatemessagestatus=&fax=&userid=&notificationformat=&qualificationcsv=", "set_profile_info.json")
      
      status = @freelancer.update_account_details(account)
      status.should == true
      
    end
    
    should "retrieve account information for another user" do

      stub_api_get("/Profile/getProfileInfo.json?userid=1", "profile_info.json")
      details = @freelancer.profile_info(1)
      details.username.should == "test"
      
    end

  end

end
