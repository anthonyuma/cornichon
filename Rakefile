require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :demo do
  require_relative "lib/cornichon"
  require_relative "lib/cornichon/writer"
  Cornichon.configure(:features_path => 'features')
  Cornichon::Writer.write!(:verbose => true)
end