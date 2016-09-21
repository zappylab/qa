require './spec_helper.rb'
require 'capybara/rspec'


# feature "Sign up, verify acc, sign in and delete acc" do
# 	scenario "sign up in protocols.io" do
# 		sign_up "protocolsuitest@gmail.com", "protocols-ui-123"
# 	end

# 	scenario "verify acc via Gmail" do
# 		verify_email "protocolsuitest@gmail.com", "protocols-ui-123", "verifying"
# 	end

# 	scenario "sign in the app with verified acc" do
# 		sign_in "protocolsuitest@gmail.com", "protocols-ui-123"
# 	end

# 	scenario "delete protocols account" do
# 		sign_in "protocolsuitest@gmail.com", "protocols-ui-123"
# 		delete_user
# 	end
# end

feature "Working with groups" do
	group_name = ""
	scenario "create new group" do
		sign_in "vasily@zappylab.com", "NLg6v5JT"
		go_to_groups
		create_group
		group_name = fill_group_name "testGroupName"
		fill_about_text "testAbout"
		fill_interest "interest"
		fill_website "http://testsite.com"
		fill_location "testLocation"
		set_group_access "invitation"
		set_group_visibility true
		save_group
	end

	scenario "delete group" do
		sign_in "vasily@zappylab.com", "NLg6v5JT"
		go_to_groups
		find_group group_name
		drill_down_group
		delete_group
	end

	scenario "create group with invitation" do
		sign_in "vasily@zappylab.com", "NLg6v5JT"
		go_to_groups
		create_group
		group_name = fill_group_name "testGroupName"
		fill_about_text "testAbout"
		fill_interest "interest"
		fill_website "http://testsite.com"
		fill_location "testLocation"
		set_group_access "invitation"
		set_group_visibility true
		invite_people "protocolsuitest1@gmail.com, protocolsuitest2@gmail.com"
		save_group
	end

	scenario "confirm invites emails" do
		verify_email "protocolsuitest1@gmail.com", "protocols-ui-123", "invitation"
	end

	scenario "confirm invites emails" do
		verify_email "protocolsuitest2@gmail.com", "protocols-ui-123", "invitation"
	end

	scenario "confirm invites in app" do
		sign_in "protocolsuitest1@gmail.com", "protocols-ui-123"
		accept_invite
	end

	scenario "confirm invites in app" do
		sign_in "protocolsuitest2@gmail.com", "protocols-ui-123"
		accept_invite
	end
end