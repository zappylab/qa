require 'capybara/dsl'
# require_relative './base_lib.rb'

# module EditProtocolsPageModule
class EditProtocolsPageClass
	include BaseLibModule

	def initialize(win)
		@window = win
		switch_to_window(@window)
		page.has_selector?(:xpath, ".//div[@class='editor-header-right']/input")
		puts 'Switched to new window and has selector'
	end

	def switch_to_tab_edit
		cutted_name = tab_name.byteslice(1, tab_name.size)
		tab = find(:xpath, ".//div[@class='tools-workarea-menu noselect']//*/li[contains(text(), '" + cutted_name +"')]")
		tab.click 
	end

	def set_protocol_name(name)
		find(:xpath, ".//div[@class='editor-header-right']/input").set('')
		find(:xpath, ".//div[@class='editor-header-right']/input").set(name)
	end

	def save_protocol
		find(:xpath, ".//div[@class='btn-list']/button[contains(text(), 'Save')]").click
	end

	def close_edit
		find(:xpath, ".//div[@class='btn-list']/button[contains(text(), 'Close')]").click
		return ViewProtocolsPageClass.new
	end

	def focus_step(step_numb)
		step = find(:xpath, ".//li[contains(@class,'editor-item')][" + step_numb.to_s + "]")
		# scroll_to_element(step)
		Capybara.current_session.driver.browser.action.send_keys(:page_up).perform
		Capybara.current_session.driver.browser.action.send_keys(:page_up).perform
		Capybara.current_session.driver.browser.action.send_keys(:page_up).perform
		step.click
	end

	def focus_name
		# scroll_to_element(find(:css, ".editor-header-right"))
		Capybara.current_session.driver.browser.action.move_to(find(:css, ".editor-header-right").native).perform
		puts 'scrolled'
	end

	def set_desc_to_step(desc_text)
		active_frame = find(:xpath, ".//li[@class='editor-item active']//*/iframe")
		within_frame active_frame do
			find(:xpath, ".//body[@id='tinymce']").set(desc_text)
		end
	end

	def remove_active_step
		find(:xpath, ".//li[@class='editor-item active']//*/div[@class='remove-step controll-item']/i").click
	end

	def add_step
		steps_list = find_all(:xpath, ".//ul[@class='editor-list']/li")
		steps_list[steps_list.size-1].click
	end

	def search_and_add_component(component_name)
		find(:xpath, ".//div[@class='stc-search']/input").set('')#.set(component_name)
		sleep(0.5)
		find(:xpath, ".//div[@class='stc-search']/input").set(component_name)
		xp_query = ".//button[contains(text(), '"+ component_name + "')]"
		find(:xpath, xp_query).click
	end

	def add_component(component_name)
		xp_query = ".//button[contains(text(), '"+ component_name + "')]"
		find(:xpath, xp_query).click
	end

	def fill_component(component_name, value)
		#TO DO this code
	end

	def move_step_up
		active_step_numb = Integer(find(:xpath, ".//li[@class='editor-item active']//*/div[@class='step-id']").text)
		if (active_step_numb != 1)
			find(:xpath, ".//li[@class='editor-item active']//*/i[@class='p-font pf-arrow-up']").click
		else
			puts "YOU ARE TRYING TO MOVE UP FIRST STEP"
		end
	end

	def move_step_down
		steps_list = find_all(:xpath, ".//ul[@class='editor-list']/li")
		active_step_numb = Integer(find(:xpath, ".//li[@class='editor-item active']//*/div[@class='step-id']").text)
		if (active_step_numb != steps_list.size-1)
			find(:xpath, ".//li[@class='editor-item active']//*/i[@class='p-font pf-arrow-down']").click
		else
			puts "YOU ARE TRYING TO MOVE DOWN LAST STEP"
		end
	end

end
# end