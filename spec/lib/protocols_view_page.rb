require 'capybara/dsl'
require_relative './base_lib.rb'
require 'time'

class ProtocolsViewPageClass
	include BaseLibModule

	def initialize
		find("#s-mce-img")
		puts "		LOG: view page initialized"
	end

	def focus_step_view(numb) 
		steps = find_all(:xpath, "//div[@id='list-of-step-move']/div")
		steps[numb-1].click
	end

	def switch_to_tab_view(tab_name)
		cutted_name = tab_name.byteslice(1, tab_name.size)
		tab = find(:xpath, ".//div[@class='tools-workarea-menu noselect']//*/li[contains(text(), '" + cutted_name +"')]")
		tab.click 
	end

end