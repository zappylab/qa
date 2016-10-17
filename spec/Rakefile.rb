require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec_1) do |t|
  t.pattern = "./sign_in_spec.rb"
  t.rspec_opts = "--format progress --format RspecJunitFormatter --out sign_in_spec.xml --format html --out sign_in_spec.html"
end

RSpec::Core::RakeTask.new(:spec_2) do |t|
  t.pattern = "./groups_workflow_spec.rb"
  t.rspec_opts = "--format progress --format RspecJunitFormatter --out groups_workflow_spec.xml --format html --out groups_workflow_spec.html"
end

RSpec::Core::RakeTask.new(:spec_3) do |t|
  t.pattern = "./protocols_workflow_spec.rb"
  t.rspec_opts = "--format progress --format RspecJunitFormatter --out protocols_workflow_spec.xml --format html --out protocols_workflow_spec.html"
end

# To launch tasks under WIN machines:
# => $env:browser='chrome' ; $env:link='http://je-protocols' ; rake sign_in groups protocols ... etc.
#
# To launch tasks under linux machine 
# => browser=chrome link=http://je-protocols rake sign_in groups protocols ... etc.

#This is list of rake tasks for test suites
task :sign_in => :spec_1 	# this task describe sign in, sign up and delete account
task :groups => :spec_2 	# this task describe group workflow: create, delete groups, create groups with invitations and confirm invite
task :protocols => :spec_3	# this task describe protocols workflow: ... 