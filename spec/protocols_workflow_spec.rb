require_relative './spec_helper.rb'
require 'time'

describe 'Working with protocols' do

	it 'should create new protocol with 3 steps' do
		loginPage = LoginPageClass.new
		startPage = loginPage.sign_in "vasily@zappylab.com", "NLg6v5JT"
		myProtocolsPage = startPage.go_to_my_protocols
		editPage = myProtocolsPage.start_new_protocol
		$created_protocol_name = "test" + (Time.now.nsec).to_s
		editPage.set_protocol_name $created_protocol_name
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
							"Expected result", "Reagent", "Software package", "External Link"] #,"Section",
		for i in 0..component_names.size-1 do
			editPage.search_and_add_component component_names[i]
		end
		# editPage.save_protocol

		editPage.fill_component "Amount", "10"
		# editPage.fill_component "Section", "Section"
		editPage.fill_component "External Link", "http://test"
		editPage.fill_component "Duration / Timer", "10"
		editPage.save_protocol
		viewPage = editPage.close_edit
		viewPage.sign_out
	end

	it 'should delete created protocol' do
		loginPage = LoginPageClass.new
		startPage = loginPage.sign_in "vasily@zappylab.com", "NLg6v5JT"
		myProtocolsPage = startPage.go_to_my_protocols
		myProtocolsPage.focus_protocol_by_name $created_protocol_name
		myProtocolsPage.delete_protocol

		begin
			puts "		LOG: Start searching deleted protocol with name = " + $created_protocol_name
			page.driver.browser.navigate.refresh
			myProtocolsPage.focus_protocol_by_name $created_protocol_name
		rescue Capybara::ElementNotFound
			puts "		LOG: Protocol with name = " + $created_protocol_name + " deleted"
		end

		myProtocolsPage.sign_out
	end

	it 'should create new protocol and publish it' do
		loginPage = LoginPageClass.new
		startPage = loginPage.sign_in "vasily@zappylab.com", "NLg6v5JT"
		myProtocolsPage = startPage.go_to_my_protocols
		editPage = myProtocolsPage.start_new_protocol
		created_protocol = "test" + (Time.now.nsec).to_s
		editPage.set_protocol_name created_protocol
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
	    editPage.go_to_my_protocols
	    myProtocolsPage.focus_protocol_by_name created_protocol
	    myProtocolsPage.publish_protocol("not unlisted")
	    myProtocolsPage.select_explorer_item_by_name "Published"
	    begin
	    	puts "		LOG: Start searching created protocol with name = " + created_protocol + " in published"
	    	myProtocolsPage.focus_protocol_by_name created_protocol
	    	puts "		LOG: Start searching created protocol with name = " + created_protocol + " found in published"
		rescue Capybara::ElementNotFound
			puts "		LOG: Created protocol with name = " + created_protocol + " wasn't published"
		end
		myProtocolsPage.sign_out
	end

	it 'should create new protocol and publish to unlisted' do
		loginPage = LoginPageClass.new
		startPage = loginPage.sign_in "vasily@zappylab.com", "NLg6v5JT"
		myProtocolsPage = startPage.go_to_my_protocols
		editPage = myProtocolsPage.start_new_protocol
		created_protocol = "test" + (Time.now.nsec).to_s
		editPage.set_protocol_name created_protocol
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
	    editPage.go_to_my_protocols
	    myProtocolsPage.select_explorer_item_by_name "My protocols"
	    myProtocolsPage.focus_protocol_by_name created_protocol
	    myProtocolsPage.publish_protocol("unlisted")
	    myProtocolsPage.select_explorer_item_by_name "Unlisted"
	    begin
	    	puts "		LOG: Start searching created protocol with name = " + created_protocol + " in unlisted"
	    	myProtocolsPage.focus_protocol_by_name created_protocol
	    	puts "		LOG: Start searching created protocol with name = " + created_protocol + " found in unlisted"
		rescue Capybara::ElementNotFound
			puts "		LOG: Created protocol with name = " + created_protocol + " wasn't published"
		end
		myProtocolsPage.sign_out
	end

	it 'should create several version of protocol' do
		loginPage = LoginPageClass.new
		startPage = loginPage.sign_in "vasily@zappylab.com", "NLg6v5JT"
		myProtocolsPage = startPage.go_to_my_protocols
		editPage = myProtocolsPage.start_new_protocol
		created_protocol = "test" + (Time.now.nsec).to_s
		editPage.set_protocol_name created_protocol
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
	    editPage.go_to_my_protocols
	    myProtocolsPage.select_explorer_item_by_name "My protocols"
	    myProtocolsPage.focus_protocol_by_name created_protocol
	    viewPage = myProtocolsPage.open_view created_protocol
	    viewPage.create_version
	    viewPage.check_version 2
	    viewPage.create_version
	    viewPage.check_version 3
	    viewPage.create_version
	    viewPage.check_version 4
	    steps_cnt = viewPage.get_steps_count
	    for i in 0..steps_cnt-1 do
	    	@annotation_text = "annotation " + (Time.now.nsec).to_s
	    	viewPage.focus_step_view i
	    	viewPage.create_annotation @annotation_text
	    end
	    viewPage.focus_step_view steps_cnt-1
	    viewPage.delete_annotation @annotation_text
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