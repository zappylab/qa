require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = "./test_spec.rb"
  t.rspec_opts = "--format RspecJunitFormatter --out results.xml --format html --out results.html"
end

task :default => :spec