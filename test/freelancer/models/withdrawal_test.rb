class WithdrawalTest < Test::Unit::TestCase

  context "withdrawal model" do

    should "create list of withdrawals based on account withdraws" do

      withdrawals = Freelancer::Models::Withdrawal.parse_collection(fixture_file("payment/get_account_withdrawal_list.json"), :shift => [ :"json-result", :items ])
      withdrawals.size.should == 1
      withdrawals.first.id.should == 36
      withdrawals.first.type.should == "paypal"
      withdrawals.first.requested_at.should == Date.parse("2010-08-08 01:58:34")
      withdrawals.first.amount.should == 100
      withdrawals.first.details.should == "PayPal withdrawal to email test@test.com"
      withdrawals.first.processing_at.should == "Mon, 9 - Tue, 10 Aug 2010"
      withdrawals.first.status.should == "Delay"

    end

  end
end
