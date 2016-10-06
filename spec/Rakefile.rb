require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec_1) do |t|
  t.pattern = "./sign_in_spec.rb"
  t.rspec_opts = "--format progress --format RspecJunitFormatter --out sign_in_spec.xml --format html --out sign_in_spec.html"
end

RSpec::Core::RakeTask.new(:spec_2) do |t|
  t.pattern = "./groups_workflow_spec.rb"
  t.rspec_opts = "--format progress --format RspecJunitFormatter --out groups_workflow_spec.xml --format html --out groups_workflow_spec.html"
end

#This is list of rake tasks for test suites
task :sign_in => :spec_1 	# this task describe sign in, sign up and delete account
task :groups => :spec_2 	# this task describe group workflow: create, delete groups, create groups with invitations and confirm invite
