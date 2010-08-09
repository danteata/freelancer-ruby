require "test_helper"

class PaymentApiTest < Test::Unit::TestCase

  context "payment api" do

    setup do
      @freelancer = Freelancer::Client.new("consumer_token", "consumer_secret")
      consumer = OAuth::Consumer.new("consumer_token", "consumer_secret", { :site => "http://api.sandbox.freelancer.com" })
      @freelancer.stubs(:consumer).returns(consumer)
      @freelancer.authorize_from_access("access_token", "access_secret")
    end

    context "account balance status" do

      should "be able to retrieve" do

        @freelancer.expects(:api_get).with("/Payment/getAccountBalanceStatus.json")
        @freelancer.account_balance

      end

      should "parse response into balance model" do

        stub_api_get("/Payment/getAccountBalanceStatus.json", "payment/get_account_balance_status.json")
        balance = @freelancer.account_balance
        balance.amount.should == 9717.55

      end 

    end

    context "account transactions" do

      should "be able to retrieve" do

        @freelancer.expects(:api_get).with("/Payment/getAccountTransactionList.json", {})
        @freelancer.transactions

      end

      should "be able to retrieve by from date" do

        @freelancer.expects(:api_get).with("/Payment/getAccountTransactionList.json", { :datefrom => "2010-08-09 17:51:00" })
        @freelancer.transactions(:from => DateTime.parse("2010-08-09 17:51:00"))

      end

      should "be able to retrieve by to date" do

        @freelancer.expects(:api_get).with("/Payment/getAccountTransactionList.json", { :dateto => "2010-08-09 17:51:00" })
        @freelancer.transactions(:to => DateTime.parse("2010-08-09 17:51:00"))

      end

      should "be able to change result count" do

        @freelancer.expects(:api_get).with("/Payment/getAccountTransactionList.json", { :count => 10 })
        @freelancer.transactions(:count => 10)

      end

      should "be able to change result page" do

        @freelancer.expects(:api_get).with("/Payment/getAccountTransactionList.json", { :page => 2 })
        @freelancer.transactions(:page => 2)

      end

      should "parse response into a collection of transactions" do
        
        stub_api_get("/Payment/getAccountTransactionList.json", "payment/get_account_transaction_list.json")
        transactions = @freelancer.transactions
        transactions.size.should == 8
        transactions.first.balance.should == 250

      end

    end

    context "account milestone list" do

      should "be able to retrieve" do

        @freelancer.expects(:api_get).with("/Payment/getAccountMilestoneList.json", {})
        @freelancer.account_milestones

      end

      should "be able to retrieve by type" do

        @freelancer.expects(:api_get).with("/Payment/getAccountMilestoneList.json", { :type => "Outgoing" })
        @freelancer.account_milestones(:type => "Outgoing")

      end

      should "be able to change result count" do

        @freelancer.expects(:api_get).with("/Payment/getAccountMilestoneList.json", { :count => 20 })
        @freelancer.account_milestones(:count => 20)

      end

      should "be able to change result page" do

        @freelancer.expects(:api_get).with("/Payment/getAccountMilestoneList.json", { :page => 2 })
        @freelancer.account_milestones(:page => 2)

      end

      should "parse response into a collection of milestones" do

        stub_api_get("/Payment/getAccountMilestoneList.json", "payment/get_account_milestone_list.json")
        milestones = @freelancer.account_milestones
        milestones.size.should == 1
        milestones.first.id.should == 988

      end

    end

    context "account withdrawal list" do

      should "be able to retrieve" do

        @freelancer.expects(:api_get).with("/Payment/getAccountWithdrawalList.json", {})
        @freelancer.account_withdrawals

      end

      should "be able to retrieve by type" do

        @freelancer.expects(:api_get).with("/Payment/getAccountWithdrawalList.json", { :type => "Outgoing" })
        @freelancer.account_withdrawals(:type => "Outgoing")

      end

      should "be able to change result count" do

        @freelancer.expects(:api_get).with("/Payment/getAccountWithdrawalList.json", { :count => 20 })
        @freelancer.account_withdrawals(:count => 20)

      end

      should "be able to change result page" do

        @freelancer.expects(:api_get).with("/Payment/getAccountWithdrawalList.json", { :page => 2 })
        @freelancer.account_withdrawals(:page => 2)

      end

      should "parse response into a collection of withdrawals" do

        stub_api_get("/Payment/getAccountWithdrawalList.json", "payment/get_account_withdrawal_list.json")
        withdrawals = @freelancer.account_withdrawals
        withdrawals.size.should == 1
        withdrawals.first.id.should == 36

      end

    end

    context "balance" do

      should "be able to retrieve" do

        @freelancer.expects(:api_get).with("/Payment/getBalance.json")
        @freelancer.balance

      end

      should "return balance as a float" do

        stub_api_get("/Payment/getBalance.json", "payment/get_balance.json")
        balance = @freelancer.balance
        balance.should == 9692.55

      end

    end

    context "withdrawal fees" do

      should "be able to retrieve" do

        @freelancer.expects(:api_get).with("/Payment/getWithdrawalFees.json")
        @freelancer.withdrawal_fees

      end

      should "parse response into a collection of withdrawal fees" do
        
        stub_api_get("/Payment/getWithdrawalFees.json", "payment/get_withdrawal_fees.json")
        fees = @freelancer.withdrawal_fees
        fees.size.should == 5
        fees.first.withdrawal_type.should == "paypal"

      end

    end


    context "project list for transfer" do

      should "be able to retrieve" do

        @freelancer.expects(:api_get).with("/Payment/getProjectListForTransfer.json")
        @freelancer.projects_for_transfer

      end

      should "parse response into a collection of projects" do

        stub_api_get("/Payment/getProjectListForTransfer.json", "payment/get_project_list_for_transfer.json")
        projects = @freelancer.projects_for_transfer
        projects.size.should == 1
        projects.first.id.should == 148

      end

    end

  end

end
