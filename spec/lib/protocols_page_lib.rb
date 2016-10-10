require 'capybara/dsl'
require_relative './base_lib.rb'

# module ProtocolsIoPageModule
class ProtocolsIoPageClass
	include BaseLibModule

	def hide_explorer
		find(:css, ".sidebar-collapse.noselect").click
		page.has_selector?(:xpath, ".//div/span[text()='►']");
	end

	def show_explorer
		find(:css, ".sidebar-collapse.noselect").click
		page.has_selector?(:xpath, ".//div/span[text()='◀']")
	end

	def select_explorer_item_by_name(branch_name)
		xpQuery = ".//*[text()='" + branch_name + "']"
		puts xpQuery
		find(:xpath, xpQuery).click
	end

	def select_file_by_number(n)
		files = find_all(:xpath, ".//div[contains(@class, 'files-row') and not( contains(@class, 'line'))]")
		files[n].click
	end

	def open_editor
		editor = window_opened_by do
			find(:xpath, ".//button//*/span[text()='Edit']/../..").click
		end
		return EditProtocolsPageClass.new(editor)
	end

	def select_protocol_by_numb
		
	end

	def select_protocol_by_name

	end
end
# end