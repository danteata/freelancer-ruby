require "oauth"
require "crack"

module Freelancer
  
  class FreelancerError < StandardError; end
  
  autoload :API, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "api")
  autoload :Client, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "client")
  
  module API
    autoload :User, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "api", "user")
    autoload :Job, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "api", "job")
    autoload :Profile, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "api", "profile")
  end
  
  module Models
    autoload :Base, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "models", "base")
    autoload :User, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "models", "user")
    autoload :JobCategory, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "models", "job_category")
    autoload :Account, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "models", "account")
    autoload :ProjectAssociation, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "models", "project_association")
  end
  
end
