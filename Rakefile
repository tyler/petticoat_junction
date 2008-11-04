require 'rake'
require 'rake/testtask'

test_files_pattern = 'test/rails_root/test/{unit,functional,other}/**/*_test.rb'
Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.pattern = test_files_pattern
  t.verbose = false
end

desc "Run the test suite"
task :default => :test

begin
  require 'rubygems'
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "petticoat_junction"
    s.summary = "Framework for periodically searching for terms on multiple services."
    s.email = "tbmcmullen@gmail.com"
    s.homepage = "http://github.com/tyler/petticoat_junction"
    s.description = s.summary
    s.authors = ["Tyler McMullen"]
    s.add_dependency 'metaid'
    s.add_dependency 'starling-starling'
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end
