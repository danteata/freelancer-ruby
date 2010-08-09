module Freelancer
  module Models
    class Withdrawal

      include JSONMapper

      # The id of the withdrawal
      #
      # Provided from:
      #   - /Payment/getAccountWithdrawalList.json
      json_attribute :id, Integer

      # The type of withdrawal
      #
      # Provided from:
      #   - /Payment/getAccountWithdrawalList.json
      json_attribute :type, String

      # The amount of money withdrawed
      #
      # Provided from:
      #   - /Payment/getAccountWithdrawalList.json
      json_attribute :amount, Float

      # The details of the withdrawal
      #
      # Provided from:
      #   - /Payment/getAccountWithdrawalList.json
      json_attribute :details, String

      # The date and time the withdrawal was requested
      #
      # Provided from:
      #   - /Payment/getAccountWithdrawalList.json
      json_attribute :requested_at, :request_at, DateTime

      # The date and time the withdrawal will be processed
      #
      # Provided from:
      #   - /Payment/getAccountWithdrawalList.json
      json_attribute :processing_at, :processing_date, String

      # The status of the withdrawal
      #
      # Provided from:
      #   - /Payment/getAccountWithdrawalList.json
      json_attribute :status, String

    end
  end
end
