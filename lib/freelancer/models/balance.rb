module Freelancer
  module Models
    class Balance

      include JSONMapper

      # The amount of money in the users account
      #
      # Provided from:
      #   - /Payment/getAccountBalanceStatus.json
      #   - /Payment/getBalance.json
      json_attribute :amount, [ :balanceamount, :balance ], Float

      # The last transaction available for the user
      #
      # Provided from:
      #   - /Payment/getAccountBalanceStatus.json
      json_attribute :last_transaction, "self", Transaction

    end
  end
end
