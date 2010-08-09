module Freelancer
  module Models
    class Transaction

      include JSONMapper

      # The id of the transaction
      #
      # Provided from:
      #   - /Payment/getAccountBalanceStatus.json
      json_attribute :id, :transactionid, Integer

      # The user id the transaction is for
      #
      # Provided from:
      #   - /Payment/getAccountBalanceStatus.json
      json_attribute :user_id, :transuserid, Integer

      # The amount of money involved in the transaction
      #
      # Provided from:
      #   - /Payment/getAccountBalanceStatus.json
      json_attribute :balance, :balanceamount, Float

      # The time the transaction was made
      #
      # Provided from:
      #   - /Payment/getAccountBalanceStatus.json
      json_attribute :made_at, :transdatetime, DateTime

      # The description of the transaction
      #
      # Provided from:
      #   - /Payment/getAccountBalanceStatus.json
      json_attribute :description, :transtext, String

    end
  end
end
