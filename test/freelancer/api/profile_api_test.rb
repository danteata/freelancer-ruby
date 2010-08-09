require "test_helper"

class ProfileApiTest < Test::Unit::TestCase

  context "profile api" do

    setup do
      @freelancer = Freelancer::Client.new("consumer_token", "consumer_secret")
      consumer = OAuth::Consumer.new("consumer_token", "consumer_secret", { :site => "http://api.sandbox.freelancer.com" })
      @freelancer.stubs(:consumer).returns(consumer)
      @freelancer.authorize_from_access("access_token", "access_secret")
    end

    context "account details" do

      should "be able to retrieve" do

        @freelancer.expects(:api_get).with("/Profile/getAccountDetails.json")
        @freelancer.account_details

      end

      should "parse response into a user" do

        stub_api_get("/Profile/getAccountDetails.json", "profile/get_account_details.json")
        account = @freelancer.account_details
        account.id.should == 123456

      end

    end

    context "profile info" do

      should "be able to retrieve" do

        @freelancer.expects(:api_get).with("/Profile/getProfileInfo.json", { :userid => 1 })
        @freelancer.profile_info(:user_id => 1)

      end
      
      should "parse response into a user" do

        stub_api_get("/Profile/getProfileInfo.json?userid=1", "profile/get_profile_info.json")
        profile = @freelancer.profile_info(:user_id => 1)
        profile.id.should == 123456

      end

    end

    context "update account details" do

      setup do

        @user = Freelancer::Models::User.new
        @user.address = Freelancer::Models::Address.new
        @user.notifications = Freelancer::Models::NotificationStatus.new
        @user.qualifications = [ "Ruby", ".NET" ]
        @user.skills = [ "Programming" ]

        @expected_params = {
          :profiletext => nil,
          :receivenewsstatus => nil,
          :city => nil,
          :addressline2 => nil,
          :bidwonnotificationstatus => nil,
          :postalcode => nil,
          :state => nil,
          :skills => 'Programming',
          :bidplacednotificationstatus => nil,
          :company_name => nil,
          :fullname => nil,
          :hourlyrate => nil,
          :newprivatemessagestatus => nil,
          :vision => nil,
          :notificationformat => nil,
          :phone => nil,
          :country => nil,
          :type_of_work => nil,
          :keywords => nil,
          :emailnotificationstatus => nil,
          :fax => nil,
          :addressline1 => nil,
          :qualificationcsv => 'Ruby,.NET'
        }

        @expected_query_string = "phone=&city=&qualificationcsv=Ruby,.NET&fullname=&state=&addressline2=&type_of_work=&skills=Programming&hourlyrate=&keywords=&bidwonnotificationstatus=&newprivatemessagestatus=&emailnotificationstatus=&postalcode=&vision=&profiletext=&country=&bidplacednotificationstatus=&fax=&receivenewsstatus=&notificationformat=&addressline1=&company_name="

      end

      should "be able to push update" do

        @freelancer.expects(:api_get).with("/Profile/setProfileInfo.json", @expected_params)
        @freelancer.update_account_details(@user)

      end

      should "parse response into a status confirmation model" do

        stub_api_get("/Profile/setProfileInfo.json?#{@expected_query_string}", "status_confirmation.json")
        status = @freelancer.update_account_details(@user)
        status.success?.should == true

      end

    end

  end

end
