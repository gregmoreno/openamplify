require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name        = "openamplify"
    gem.summary     = "Wrapper for the OpenAmplify API"
    gem.description = "The OpenAmplify API reads text you supply and returns linguistic data explaining and classifying the content."
    gem.email       = "rubyoncloud@gmail.com"
    gem.homepage    = "http://github.com/gregmoreno/openamplify"
    gem.authors     = ["Greg Moreno"]

    gem.add_dependency "json", "~>1.2"

    gem.add_development_dependency "shoulda", "~> 2.11"  

    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.ruby_opts << "-rubygems"
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end
# Note to run a single test do:
# ruby -Ilib test/test_foo.rb


begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "openamplify #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
