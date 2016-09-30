# require './spec_helper.rb'

feature "Sign up, verify acc, sign in and delete acc" do
	scenario "delete protocols account" do
		sign_in "protocolsuitest@gmail.com", "protocols-ui-123"
		delete_user
	end

	scenario "sign up in protocols.io" do
		sign_up "protocolsuitest@gmail.com", "protocols-ui-123"
	end

	scenario "verify acc via Gmail" do
		verify_email "protocolsuitest@gmail.com", "protocols-ui-123", "verifying"
	end

	scenario "sign in the app with verified acc" do
		sign_in "protocolsuitest@gmail.com", "protocols-ui-123"
	end
end

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

	scenario "delete created group" do
		sign_in "vasily@zappylab.com", "NLg6v5JT"
		go_to_groups
		find_group group_name
		drill_down_group
		delete_group
	end

	scenario "delete protocols account" do
		sign_in "protocolsuitest2@gmail.com", "protocols-ui-123"
		delete_user
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
		sign_out
	end

	scenario "confirm invites emails for first user ---SIGNED UP---" do
		verify_email "protocolsuitest1@gmail.com", "protocols-ui-123", "invitation-signed"
	end

	scenario "confirm invites emails for second user ---NOT SIGNED UP---" do
		verify_email "protocolsuitest2@gmail.com", "protocols-ui-123", "invitation-not-signed"
		verify_email "protocolsuitest2@gmail.com", "protocols-ui-123", "verifying"
	end
end