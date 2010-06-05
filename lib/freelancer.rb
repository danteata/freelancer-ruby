require "oauth"
require "json/ext"
require "htmlentities"

module Freelancer
  
  class FreelancerError < StandardError; end
  
  autoload :API, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "api")
  autoload :Client, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "client")
  
  module API
    autoload :User, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "api", "user")
    autoload :Job, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "api", "job")
    autoload :Profile, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "api", "profile")
    autoload :Employer, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "api", "employer")
  end
  
  module Models
    autoload :Base, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "models", "base")
    autoload :User, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "models", "user")
    autoload :JobCategory, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "models", "job_category")
    autoload :Account, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "models", "account")
    autoload :ProjectAssociation, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "models", "project_association")
    autoload :Project, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "models", "project")
  end
  
  module Support
    autoload :JSONMapper, File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "support", "json_mapper")
  end
  
end

#
# Add some Ruby object extensions if they're missing
# -----------------------------------------------------------------------------

# Hash extensions
#unless {}.respond_to?(:symbolize_keys)
#  require File.join(File.expand_path(File.dirname(__FILE__)), "freelancer", "extensions", "hash")
#end
