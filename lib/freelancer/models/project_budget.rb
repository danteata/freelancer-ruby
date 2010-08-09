module Freelancer
  module Models
    class ProjectBudget

      include JSONMapper

      # Budget id
      json_attribute :id, Integer

      # Minimum budget
      json_attribute :minimum_budget, :minbudget, Integer

      # Maximum budget
      json_attribute :maximum_budget, :maxbudget, Integer

      # Budget name
      json_attribute :name, String

    end
  end
end
