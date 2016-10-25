require_relative './spec_helper.rb'
require 'time'

describe 'Working with protocols' do
	# it 'should create new protocol' do
	# 	loginPage = LoginPageModule::LoginPageClass.new
	# 	protocolsStartPage =$loginPage.sign_in "protocolsuitest@gmail.com", "protocols-ui-123"
	# end

	it 'should create new protocol with 3 steps' do
		loginPage = LoginPageClass.new
		startPage = loginPage.sign_in "vasily@zappylab.com", "NLg6v5JT"
		myProtocolsPage = startPage.go_to_my_protocols
		editPage = myProtocolsPage.start_new_protocol
		editPage.set_protocol_name "test" + (Time.now.nsec).to_s
		editPage.save_protocol
		for i in 0..2 do
			editPage.add_step
		end
		editPage.focus_name
		editPage.save_protocol
		for i in 1..4 do
			editPage.focus_name
			editPage.focus_step i
			editPage.set_desc_to_step (Time.now.nsec).to_s
		end
		editPage.save_protocol

		component_names = ["Amount", "Annotation", "Command", "Dataset", "Duration / Timer",
							"Expected result", "Reagent", "Section", "Software package"] #"External Link",
		for i in 0..component_names.size-1 do
			editPage.search_and_add_component component_names[i]
		end
		# editPage.save_protocol

		editPage.fill_component "Amount", "10"
		editPage.fill_component "Section", "Section"
		editPage.fill_component "External Link", "http://test"
		editPage.fill_component "Duration / Timer", "10"
		editPage.save_protocol
		viewPage = editPage.close_edit
		viewPage.sign_out
	end

	# it 'should modify created protocol' do
	# 	loginPage = LoginPageClass.new
	# 	startPage =loginPage.sign_in "vasily@zappylab.com", "NLg6v5JT"
	# 	myProtocols = startPage.go_to_my_protocols
	# 	myProtocols.select_explorer_item_by_name 'Personal'
	# 	myProtocols.select_file_by_number 1
	# 	editPage = myProtocols.open_editor
	# 	editPage.set_protocol_name 'testName'
	# 	editPage.save_protocol
	# 	editPage.sign_out
	# end
end