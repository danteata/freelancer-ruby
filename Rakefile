require "rake"
require "bundler"
require "rake/testtask"
require "rake/rdoctask"

# Gemcutter/Jeweler configuration
# -----------------------------------------------------------------------------
begin

  require "jeweler"

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

rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end


# Test setup
# -----------------------------------------------------------------------------
Rake::TestTask.new(:test) do |t|
  t.libs << "lib" << "test"
  t.ruby_opts << "-rubygems"
  t.pattern = "test/**/*_test.rb"
  t.verbose = true
end

# RDoc setup
# ----------------------------------------------------------------------------
Rake::RDocTask.new do |rdoc|
  
  version = File.exists?("VERSION") ? File.read("VERSION") : ""

  rdoc.rdoc_dir = "rdoc"
  rdoc.title = "freelancer #{version}"
  rdoc.rdoc_files.include("README.rdoc")
  rdoc.rdoc_files.include("lib/**/*.rb")

end

# Rcov setup
# ----------------------------------------------------------------------------
begin

  require "rcov/rcovtask"

  Rcov::RcovTask.new do |test|

    test.libs << "test"
    test.pattern = "test/**/*_test.rb"
    test.verbose = "true"

  end

rescue LoadError
  task :rcov do
    abort "Rcov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

# Task setups
# -----------------------------------------------------------------------------
task :test => :check_dependencies
task :default => :test
