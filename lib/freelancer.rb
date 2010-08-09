require "oauth"
require "htmlentities"
require "json_mapper"

module Freelancer
  
  class FreelancerError < StandardError; end
  
  autoload :API, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "api")
  autoload :Client, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "client")
  
  module API
    autoload :User, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "api", "user")
    autoload :Job, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "api", "job")
    autoload :Profile, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "api", "profile")
    autoload :Employer, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "api", "employer")
    autoload :Freelancer, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "api", "freelancer")
    autoload :Common, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "api", "common")
    autoload :Payment, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "api", "payment")
    autoload :Notification, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "api", "notification")
    autoload :Project, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "api", "project")
    autoload :Message, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "api", "message")
  end
  
  module Models
    autoload :Address, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "models", "address")
    autoload :Rating, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "models", "rating")
    autoload :NotificationStatus, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "models", "notification_status")
    autoload :User, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "models", "user")
    autoload :Review, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "models", "review")
    autoload :JobCategory, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "models", "job_category")
    autoload :Job, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "models", "job")
    autoload :Project, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "models", "project")
    autoload :Eligibility, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "models", "eligibility")
    autoload :ConfigVersion, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "models", "config_version")
    autoload :Balance, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "models", "balance")
    autoload :Transaction, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "models", "transaction")
    autoload :Milestone, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "models", "milestone")
    autoload :Withdrawal, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "models", "withdrawal")
    autoload :WithdrawalFee, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "models", "withdrawal_fee")
    autoload :Notification, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "models", "notification")
    autoload :News, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "models", "news")
    autoload :ProjectFee, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "models", "project_fee")
    autoload :ProjectOptions, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "models", "project_options")
    autoload :Bid, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "models", "bid")
    autoload :Message, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "models", "message")
    autoload :ProjectBudget, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "models", "project_budget")
  end
  
end

#
# Add some Ruby object extensions if they're missing
# -----------------------------------------------------------------------------

# Hash extensions
#unless {}.respond_to?(:symbolize_keys)
#  require File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "extensions", "hash")
#end
