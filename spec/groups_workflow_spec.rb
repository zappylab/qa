require_relative './spec_helper.rb'
# require 'capybara/rspec'
# include BaseLibModule

describe 'Working with GROUPS' do
	group_name = ''
	it 'should CREATE new GROUP' do
		$loginPage = LoginPageModule::LoginPageClass.new
		$protocolsStartPage =$loginPage.sign_in "protocolsuitest@gmail.com", "protocols-ui-123"
		protocolsGroupPage = $protocolsStartPage.go_to_groups
		protocolsGroupPage.create_group
		group_name = protocolsGroupPage.fill_group_name "testGroupName"
		protocolsGroupPage.fill_about_text "testAbout"
		protocolsGroupPage.fill_interest "interest"
		protocolsGroupPage.fill_website "http://testsite.com"
		protocolsGroupPage.fill_location "testLocation"
		protocolsGroupPage.set_group_access "invitation"
		protocolsGroupPage.set_group_visibility true
		protocolsGroupPage.save_group
		protocolsGroupPage.sign_out
	end

	it 'should DELETE created GROUP' do
		$loginPage.sign_in "protocolsuitest@gmail.com", "protocols-ui-123"
		protocolsGroupPage = $protocolsStartPage.go_to_groups
		protocolsGroupPage.find_group group_name
		inGroup = protocolsGroupPage.drill_down_group
		inGroup.delete_group
	end

	it '---PRECONDITIONS: delete protocolsuitest2 acc--- should DELETE activated acc' do
		$protocolsStartPage = $loginPage.sign_in "protocolsuitest2@gmail.com", "protocols-ui-123"
		userProfilePage = $protocolsStartPage.go_to_user_profile
		userProfilePage.delete_user
	end

	it "should CREATE GROUP with invitation" do
		$loginPage.sign_in "protocolsuitest@gmail.com", "protocols-ui-123"
		groupsPage = $protocolsStartPage.go_to_groups
		groupsPage.create_group
		group_name = groupsPage.fill_group_name "testGroupName"
		groupsPage.fill_about_text "testAbout"
		groupsPage.fill_interest "interest"
		groupsPage.fill_website "http://testsite.com"
		groupsPage.fill_location "testLocation"
		groupsPage.set_group_access "invitation"
		groupsPage.set_group_visibility true
		groupsPage.invite_people "protocolsuitest1@gmail.com, protocolsuitest2@gmail.com"
		groupsPage.save_group
		groupsPage.sign_out
	end

	it "should CONFIRM invites EMAILS for first user ---SIGNED UP---" do
		$gmail = GoogleEmailModule::GoogleEmailClass.new
		$gmail.verify_email "protocolsuitest1@gmail.com", "protocols-ui-123", "invitation-signed"
	end

	it "should CONFIRM invites EMAILS for second user ---NOT SIGNED UP---" do
		$gmail.verify_email "protocolsuitest2@gmail.com", "protocols-ui-123", "invitation-not-signed"
		$gmail.verify_email "protocolsuitest2@gmail.com", "protocols-ui-123", "verifying"
	end
end

# describe 'WORKING with PROTOCOLS' do

# 	it 'should MODIFY created PROTOCOL' do
# 		# $loginPage.sign_in "vasily@zappylab.com", "NLg6v5JT"
# 		# $protocolsStartPage.
# 		$loginPage = LoginPageModule::LoginPageClass.new
# 		$loginPage.sign_in "vasily@zappylab.com", "NLg6v5JT"

# 		visit 'http://je-protocols/view/test-pr-fngbmbw'

# 		find(:xpath, ".//div[@class='protocol-actions']/a[text()='Edit']").click
# 		protocolEditPage = EditProtocolsPageModule::EditProtocolsPageClass.new
# 		protocolEditPage.set_protocol_name 'test Name'
# 		protocolEditPage.save_protocol
# 		protocolEditPage.sign_out
# 	end
# end