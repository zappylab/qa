require 'capybara/dsl'
require_relative './base_lib.rb'

# module ProtocolsIoPageModule
class MyProtocolsPageClass
	include BaseLibModule

	def initialize
		xpQuery = ".//h3[text()='My protocols']"
		puts xpQuery
		find(:xpath, xpQuery)
	end

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
		files = find_all(:xpath, ".//div[contains(@class, 'files-row') and not( contains(@class, 'line'))]/div[@class='files-col files-type']")
		files[n-1].click
	end

	def open_editor
		editor = window_opened_by do
			find(:xpath, ".//button//*/span[text()='Edit']/../..").click
		end
		return EditProtocolsPageClass.new(editor)
	end

	def select_protocol_by_numb
		
	end

	def focus_protocol_by_name(protocol_name)
		protocol = find(:xpath, ".//div[@class='files-col files-name' and contains(text(), '" + protocol_name +"')]")
		protocol.click
	end

	def start_new_protocol
		find(:xpath, ".//button[@class='btn new-sidebar-btn']").click
		editor = window_opened_by do
			find(:xpath, ".//ul[@class='list-nav']/li[2]").click
		end
		current_window.close
		return EditProtocolsPageClass.new(editor)
	end

	def delete_protocol
		find(:xpath, ".//span[text()='Delete']/..").click
		find(:xpath, ".//button[text()='Delete']").click
	end

	def publish_protocol(flag)
		find(:xpath, ".//button[text()='Publish']").click
		if flag == "unlisted"
			find(:xpath, ".//label[@for='checkbox-share']").click
		end
		find(:xpath, ".//span[text()='Publish']/../..").click
		while self.check_publishing() != nil do
			"		LOG: publishing protocol..."
		end
		if flag != "unlisted"
			find(:xpath, ".//span[text()='Close']/..").click
		else
			find(:xpath, ".//div[@class='navigation']/button").click
		end
	end

	def check_publishing
		begin
			spin = find(:xpath, ".//div[@class='protocols-spinner-bars psb-small']", wait: 5)
			return spin
		rescue Capybara::ElementNotFound
			puts '		LOG: Protocol published...'
		end
	end
end
# end