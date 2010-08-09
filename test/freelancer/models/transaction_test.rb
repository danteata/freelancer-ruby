class TransactionTest < Test::Unit::TestCase

  context "transaction model" do

    should "create a transaction based on account balance JSON" do

      balance = Freelancer::Models::Transaction.parse(fixture_file("payment/get_account_balance_status.json"), :shift => :"json-result")
      balance.id.should == 987
      balance.user_id.should == 123456
      balance.balance.should == 9717.55
      balance.description.should == "Transfer from test-username for project Test project (Full payment for completed project)"
      balance.made_at.should == Date.parse("08/08/2010 at 1:53 EDT")

    end

    should "create list of transaction based on JSON" do

      transactions = Freelancer::Models::Transaction.parse_collection(fixture_file("payment/get_account_transaction_list.json"), :shift => [ :"json-result", :items ])
      transactions.size.should == 8

      transactions.first.id.should == 987
      transactions.first.balance.should == 250
      transactions.first.made_at.should == Date.parse("2010-08-08 01:53:33")
      transactions.first.description.should == "Transfer from test-username for project Test project (Full payment for completed project)"

    end

  end
end
