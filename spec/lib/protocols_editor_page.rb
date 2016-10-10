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

	def set_protocol_name(name)
		find(:xpath, ".//div[@class='editor-header-right']/input").set('')
		find(:xpath, ".//div[@class='editor-header-right']/input").set(name)
	end

	def save_protocol
		find(:xpath, ".//div[@class='btn-list']/button[contains(text(), 'Save')]").click
	end

	def close_edit
		find(:xpath, ".//div[@class='btn-list']/button[contains(text(), 'Close')]").click
	end

	def activate_step(step_numb)
		steps_list = find_all(:xpath, ".//ul[@class='editor-list']/li")
		case step_numb
			when steps_list.size 
				puts 'YOU ARE TRYING TO PUSH ADD STEP'
			when (step_numb<steps_list.size) && (step_numb>0)
				steps_list[step_numb-1].click
			end
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