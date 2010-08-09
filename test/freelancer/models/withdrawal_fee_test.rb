class WithdrawalFeeTest < Test::Unit::TestCase

  context "withdrawal fee model" do

    should "create list of fees based on JSON" do

      fees = Freelancer::Models::WithdrawalFee.parse_collection(fixture_file("payment/get_withdrawal_fees.json"), :shift => [ :"json-result", :items, :fee ])
      fees.size.should == 5
      fees.first.withdrawal_type.should == "paypal"
      fees.first.fee.should == 1
      fees.first.minimum_amount.should == 30
      fees.first.maximum_amount.should == 10000
      fees.first.country_code.should == ""

    end

  end

end
