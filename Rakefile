
require "bundler/gem_tasks"
require "rake/testtask"
require "cosmos"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.test_files = FileList["test/*_test.rb"]
  t.verbose = true
end

task :default => :test
