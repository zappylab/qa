require_relative './spec_helper.rb'

describe 'Working with protocols' do
	# it 'should create new protocol' do
	# 	loginPage = LoginPageModule::LoginPageClass.new
	# 	protocolsStartPage =$loginPage.sign_in "protocolsuitest@gmail.com", "protocols-ui-123"
	# end

	it 'should create new protocol with 3 steps'
		loginPage = LoginPageClass.new
		startPage = loginPage.sign_in "vasily@zappylab.com", "NLg6v5JT"
		myProtocols page = startPage.go_to_my_protocols
		editPage = myProtocols.start_new_protocol
		for i in 0..2
			editPage.add_step
		end

		for i in 1..3
			editPage.activate_step i
			editPage.add_step
		end

	end

	it 'should modify created protocol' do
		loginPage = LoginPageClass.new
		startPage =loginPage.sign_in "vasily@zappylab.com", "NLg6v5JT"
		myProtocols = startPage.go_to_my_protocols
		myProtocols.select_explorer_item_by_name 'Personal'
		myProtocols.select_file_by_number 1
		editPage = myProtocols.open_editor
		editPage.set_protocol_name 'testName'
		editPage.save_protocol
		editPage.sign_out
	end
end