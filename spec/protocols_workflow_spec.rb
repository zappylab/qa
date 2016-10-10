require_relative './spec_helper.rb'

describe 'Working with protocols' do
	# it 'should create new protocol' do
	# 	loginPage = LoginPageModule::LoginPageClass.new
	# 	protocolsStartPage =$loginPage.sign_in "protocolsuitest@gmail.com", "protocols-ui-123"
	# end

	it 'should modify created protocol' do
		loginPage = LoginPageModule::LoginPageClass.new
		protocolsStartPage =loginPage.sign_in "vasily@zappylab.com", "NLg6v5JT"
		protocolsIoPage = protocolsStartPage.go_to_your_protocols
		protocolsIoPage.select_explorer_item_by_name 'Personal'
		protocolsIoPage.select_file_by_number 1
		protocolsEditPage = protocolsIoPage.open_editor
		protocolsEditPage.set_protocol_name 'testName'
		protocolsEditPage.save_protocol
		protocolsEditPage.sign_out
	end
	
end