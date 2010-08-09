module Freelancer
  module Models
    class WithdrawalFee

      include JSONMapper

      # The withdrawal type
      #
      # Provided from:
      #   - /Payment/getWithdrawalFees.json
      json_attribute :withdrawal_type, :withdrawtype, String

      # The withdrawal fee
      #
      # Provided from:
      #   - /Payment/getWithdrawalFees.json
      json_attribute :fee, :charge, Integer

      # The minimum amount that can be withdrawn
      #
      # Provided from:
      #   - /Payment/getWithdrawalFees.json
      json_attribute :minimum_amount, :minamount, Integer

      # The maximum amount that can be withdrawn
      #
      # Provided from:
      #   - /Payment/getWithdrawalFees.json
      json_attribute :maximum_amount, :maxamount, Integer

      # The country code where the withdrawal type is available
      #
      # Provided from:
      #   - /Payment/getWithdrawalFees.json
      json_attribute :country_code, :countrycode, String

    end
  end
end
