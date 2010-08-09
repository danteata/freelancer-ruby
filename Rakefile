require "rake"
require "jeweler"
require "bundler"
require "rake/testtask"

# Gemcutter/Jeweler configuration
# -----------------------------------------------------------------------------
Jeweler::Tasks.new do |gem|

  gem.name = "freelancer"
  gem.summary = "Freelancer API"
  gem.description = "Ruby gem implementation of the Freelancer.com API"
  gem.email = "tanordheim@gmail.com"
  gem.homepage = "http://github.com/tanordheim/freelancer-ruby"
  gem.authors = [ "Trond Arve Nordheim" ]
  
  gem.add_bundler_dependencies
  
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
