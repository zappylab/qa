require_relative './spec_helper.rb'
# require 'capybara/rspec'
# include BaseLibModule

describe 'Working with GROUPS' do
	$group_name = ''
	# it 'should CREATE new GROUP' do
	# 	$loginPage = LoginPageClass.new
	# 	$protocolsStartPage =$loginPage.sign_in "protocolsuitest1@gmail.com", "protocols-ui-123"
	# 	protocolsGroupPage = $protocolsStartPage.go_to_groups
	# 	protocolsGroupPage.create_group
	# 	protocolsGroupPage.fill_interest "interest"
	# 	protocolsGroupPage.fill_about_text "testAbout"
	# 	protocolsGroupPage.fill_website "http://testsite.com"
	# 	protocolsGroupPage.fill_location "testLocation"
	# 	protocolsGroupPage.set_group_access "invitation"
	# 	protocolsGroupPage.set_group_visibility true
	# 	$group_name = protocolsGroupPage.fill_group_name "tgn"
	# 	inGroup = protocolsGroupPage.save_group
	# 	protocolsGroupPage.sign_out
	# end

	# it 'should DELETE created GROUP' do
	# 	$loginPage.sign_in "protocolsuitest1@gmail.com", "protocols-ui-123"
	# 	protocolsGroupPage = $protocolsStartPage.go_to_groups
	# 	protocolsGroupPage.find_group $group_name
	# 	inGroup = protocolsGroupPage.drill_down_group
	# 	inGroup.delete_group
	# end

	# it '---PRECONDITIONS: delete protocolsuitest3 acc--- should DELETE activated acc' do
	# 	$protocolsStartPage = $loginPage.sign_in "protocolsuitest3@gmail.com", "protocols-ui-123"
	# 	userProfilePage = $protocolsStartPage.go_to_user_profile
	# 	userProfilePage.delete_user
	# end

	# it "should CREATE GROUP with invitation" do
	# 	$loginPage = LoginPageClass.new
	#  	$protocolsStartPage = $loginPage.sign_in "protocolsuitest1@gmail.com", "protocols-ui-123"
	# 	groupsPage = $protocolsStartPage.go_to_groups
	# 	groupsPage.create_group
	# 	groupsPage.fill_about_text "testAbout"
	# 	groupsPage.fill_interest "interest"
	# 	groupsPage.fill_website "http://testsite.com"
	# 	groupsPage.fill_location "testLocation"
	# 	groupsPage.set_group_access "invitation"
	# 	groupsPage.set_group_visibility true
	# 	groupsPage.invite_people "protocolsuitest2@gmail.com, protocolsuitest3@gmail.com"
	# 	$group_name = groupsPage.fill_group_name "tgn"
	# 	inGroup = groupsPage.save_group
	# 	groupsPage.sign_out
	# end

	# it "should CONFIRM invites EMAILS for first user ---SIGNED UP---" do
	# 	$gmail = GoogleEmailClass.new
	# 	$gmail.verify_email "protocolsuitest2@gmail.com", "protocols-ui-123", "invitation-signed"
	# end

	# it "should CONFIRM invites EMAILS for second user ---NOT SIGNED UP---" do
	# 	$gmail.verify_email "protocolsuitest3@gmail.com", "protocols-ui-123", "invitation-not-signed"
	# 	$gmail.verify_email "protocolsuitest3@gmail.com", "protocols-ui-123", "verifying"
	# end

	it 'should CREATE GROUP, ADD DISCUSSION and MAKE POST to DISCUSSION' do
		$loginPage = LoginPageClass.new
		$protocolsStartPage =$loginPage.sign_in "protocolsuitest1@gmail.com", "protocols-ui-123"
		protocolsGroupPage = $protocolsStartPage.go_to_groups
		protocolsGroupPage.create_group
		protocolsGroupPage.fill_interest "interest"
		protocolsGroupPage.fill_about_text "testAbout"
		protocolsGroupPage.fill_website "http://testsite.com"
		protocolsGroupPage.fill_location "testLocation"
		protocolsGroupPage.set_group_access "invitation"
		protocolsGroupPage.set_group_visibility true
		$group_name = protocolsGroupPage.fill_group_name "tgn"
		inGroupPage = protocolsGroupPage.save_group
		# inGroupPage.click_commutiny_menu_item 'Discussions'
		inGroupPage.click_plus_button_on_item 'Discussions'
		inDiscussionPage = inGroupPage.add_discussion 'discussion_title', 'discussion_text'
		inDiscussionPage.add_post 'text_to_post'
		inDiscussionPage.sign_out
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