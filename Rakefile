require "rake"
require "jeweler"
require "rake/testtask"

# Gemcutter/Jeweler configuration
# -----------------------------------------------------------------------------
Jeweler::Tasks.new do |gem|

  gem.name = "freelancer"
  gem.summary = "Freelancer API"
  gem.description = "Ruby gem implementation of the Freelancer.com API"
  gem.email = "tanordheim@gmail.com"
  gem.homepage = "http://github.com/tanordheim/freelancer"
  gem.authors = [ "Trond Arve Nordheim" ]
  
  gem.files = [ "LICENSE", "Rakefile", "Readme.RDOC", "VERSION" ]
  
  gem.add_dependency "oauth", ">= 0.4.0"
  gem.add_dependency "crack", ">= 0.1.7"
  
  gem.add_development_dependency "shoulda", ">= 2.10.3"
  gem.add_development_dependency "mcmire-matchy", ">= 0.5.2"
  gem.add_development_dependency "mocha", ">= 0.9.8"
  gem.add_development_dependency "fakeweb", ">= 1.2.8"

end
Jeweler::GemcutterTasks.new

# Test setup
# -----------------------------------------------------------------------------
Rake::TestTask.new(:test) do |t|
  t.libs << "lib" << "test"
  t.ruby_opts << "-rubygems"
  t.pattern = "test/**/*_test.rb"
  t.verbose = true
end

# Task setups
# -----------------------------------------------------------------------------
task :test => :check_dependencies
task :default => :test
