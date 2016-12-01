require 'capybara/dsl'
require_relative './base_lib.rb'
require 'time'

class ProtocolsViewPageClass
	include BaseLibModule

	def initialize(window)
		@window = window
		switch_to_window(@window)
		find("#s-mce-img")
		puts "		LOG: view page initialized"

	end

	def create_fork
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
		find(:xpath, ".//*[@class='small-title-bold']").click
		Capybara.current_session.driver.browser.action.send_keys(:page_up).perform
		find(:css, ".vpt-version").hover
		cur_window = Capybara.current_window
		new_version_tab = window_opened_by do
			find(:xpath, "//a[text()='New version']").click
			find(:xpath, ".//div[@class='navigation']/a[3]").click
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

end