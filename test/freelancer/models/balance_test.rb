class BalanceTest < Test::Unit::TestCase

  context "balance model" do

    should "create balance instance based on JSON" do

      balance = Freelancer::Models::Balance.parse(fixture_file("payment/get_balance.json"), :shift => :"json-result")
      balance.amount.should == 9692.55

    end

    should "create balance instance based on balance status JSON" do

      balance = Freelancer::Models::Balance.parse(fixture_file("payment/get_account_balance_status.json"), :shift => :"json-result")
      balance.amount.should == 9717.55
      balance.last_transaction.id.should == 987
      balance.last_transaction.user_id.should == 123456
      balance.last_transaction.made_at.should == Date.parse("08/08/2010 at 1:53 EDT")
      balance.last_transaction.description.should == "Transfer from test-username for project Test project (Full payment for completed project)"

    end

  end
end
