module Freelancer
  module Models
    class Address

      include JSONMapper

      # The first streetname of the address
      #
      # Provided from:
      #   - /Profile/getAccountDetails.json
      json_attribute :street_name, :addressline1, String

      # The second streetname of the address
      #
      # Provided from:
      #   - /Profile/getAccountDetails.json
      json_attribute :street_name_2, :addressline2, String

      # The postal code of the address
      #
      # Provided from:
      #   - /Profile/getAccountDetails.json
      json_attribute :postal_code, :postalcode, String

      # The city part of the address
      #
      # Provided from:
      #   - /User/getUserDetails.json
      json_attribute :city, String


      # The state part of the address
      #
      # Provided from:
      #   - /Profile/getAccountDetails.json
      json_attribute :state, String

      # The country the address is located in
      # 
      # Provided from:
      #   - /User/getUserDetails.json
      json_attribute :country, String

    end
  end
end
