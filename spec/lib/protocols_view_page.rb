require 'capybara/dsl'
require_relative './base_lib.rb'
require 'time'

class ProtocolsViewPageClass
	include BaseLibModule

	def initialize(window)
		@window = window
		switch_to_window(@window)
		begin
			find("#s-mce-img")
		rescue Capybara::ElementNotFound
			find(".ep-main")
		rescue Capybara::ElementNotFound
			puts "		LOG: ERROR LOAD /VIEW PAGE"
			fail
		end
		puts "		LOG: view page initialized"
	end

	def run_protocol
		cur_window = Capybara.current_window
		run_tab = window_opened_by do
			find(:css, ".vpt-run").click
		end
		cur_window.close
		switch_to_window(run_tab)
		return RunProtocolsPageClass.new
	end

	def create_fork
		find(:xpath, ".//li[@data-position][1]").click
		for i in 1..3 do
			Capybara.current_session.driver.browser.action.send_keys(:page_up).perform
		end
		puts '		LOG: creating fork of protocol'
		find(:xpath, ".//button[@class='up-tipsy']").click
		find(:xpath, ".//button[text()='Continue']").click
		puts '		LOG: fork created'
		find(:xpath, "//a[@class='btn btn-gray' and text()='Close']").click
	end

	def focus_step_view(numb) 
		xpath = ".//div[@id='list-of-step-move']//*/div[contains(@class, 'step-list-item')]"
		steps = find_all(:xpath, xpath)
		steps[numb].click
		puts "Focused step " + numb.to_s + " on view page"
	end

	def get_steps_count
		xpath = ".//div[@id='list-of-step-move']//*/div[contains(@class, 'step-list-item')]"
		steps = find_all(:xpath, xpath)
		return steps.size
	end

	def switch_to_tab_view(tab_name)
		cutted_name = tab_name.byteslice(1, tab_name.size)
		tab = find(:xpath, ".//div[@class='tools-workarea-menu noselect']//*/li[contains(text(), '" + cutted_name +"')]")
		tab.click 
	end

	def create_version
		find(:xpath, ".//li[@data-position][1]").click
		for i in 1..3 do
			Capybara.current_session.driver.browser.action.send_keys(:page_up).perform
		end
		find(:css, ".vpt-version").click
		find(:css, ".vpt-version").hover

		find(:xpath, "//a[text()='New version']").click
			# find(:xpath, ".//div[@class='navigation']/a[3]").click
		find(:xpath, ".//div[@class='navigation']/button[@class='btn btn-blue']").click
		cur_window = Capybara.current_window
		new_version_tab = window_opened_by do
			find(:xpath, ".//div[@class='navigation']/a[@class='btn btn-blue'][2]").click
		end
		cur_window.close
		switch_to_window(new_version_tab)
	end

	def check_version(expected_version)
		find(:xpath, ".//div[@class='vpt-version']/span[contains(text(), '" + expected_version.to_s + "')]")
		puts "		LOG: version " + expected_version.to_s + "of protocol created"
	end

	def open_edit
		editor = window_opened_by do
			find(:xpath, ".//button//*/span[text()='Edit']/../..").click
		end
		current_window.close
		return EditProtocolsPageClass.new(editor)
	end

	def create_annotation(annotation_text)
		find(:css, ".small-title-lower").click
		annotation_frame = find(:css, "#anno-mce-undefined_ifr")
		within_frame annotation_frame do 
			find(:css, "#tinymce").set(annotation_text)
		end
		find(:xpath, ".//div[@class='nav']/button[text()='Save annotation']").click
		find(:xpath, ".//div[@class='editable-content']/p[text()='" + annotation_text +"']")
	end

	def delete_annotation(annotation_text)
		find(:xpath, ".//div[@class='discussion-module-body']//*/p[text()='" + annotation_text + "']")
		xpQuery = ".//div[@class='discussion-module-body']//*" + 
			"/p[text()='" + annotation_text +"']/../../preceding-sibling::div[@class='discussion-module-header']" +
			 "//*/*[contains(@class, 'pf-trash')]"
		find(:xpath, xpQuery).click
	end

	def confirm_transfer(protocol_name)
		find(".ep-main")
		find(:xpath, ".//a[text()=' Click to confirm/decline protocol owhership']").click
		find(:xpath, ".//button[text()='Confirm']").click
		find(:xpath, ".//h2[text()='" + protocol_name +"']")
	end

end