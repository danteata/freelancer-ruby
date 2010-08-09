module Freelancer
  module Models
    class ProjectOptions

      include JSONMapper

      # Featured project
      json_attribute :featured, Boolean

      # Non public project
      json_attribute :non_public, :nonpublic, Boolean

      # Trial project
      json_attribute :trial, Boolean

      # Full time project
      json_attribute :full_time, :fulltime, Boolean

      # Gold members only project
      json_attribute :gold_members_only, :for_gold_members, Boolean

      # Hidden bids
      json_attribute :hidden_bids, Boolean

      def featured?; self.featured; end
      def non_public?; self.non_public; end
      def trial?; self.trial; end
      def full_time?; self.full_time; end
      def gold_members_only?; self.gold_members_only; end
      def hidden_bids?; self.hidden_bids; end

    end
  end
end
