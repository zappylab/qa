require 'capybara/dsl'
require_relative './base_lib.rb'

# module ProtocolsIoPageModule
class MyProtocolsPageClass
	include BaseLibModule

	def initialize
		xpQuery = ".//h3[text()='My private']"
		puts xpQuery
		find(:xpath, xpQuery)
		begin
			find(:xpath, ".//div[@class='files-row'][1]")
		rescue Capybara::ElementNotFound
			find(:css, "div.empty-folders.empty-folders-hover")
		end			
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
		xpQuery = ".//h3[text()='" + branch_name + "']"
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
		page.driver.browser.navigate.refresh
		protocol = find(:xpath, ".//div[contains(@class, 'files-protocol-name') and text()='" + protocol_name + "']")
		protocol.click
	end

	def open_share
		find(:xpath, ".//button[@class='btn default-btn']//*[@class='p-font pf-face-left']/../..").click
	end

	def open_transfer_ownership
		find(:xpath, ".//button/span[text()='Transfer ownership']/..").click
	end

	def share_with_user(username, protocol_name)
		self.focus_protocol_by_name(protocol_name)
		self.open_share
		find(:xpath, ".//div[@class='se-input']/input").set(username)
		find(:xpath, ".//div[@class='se-input']/input/following-sibling::i").click
		find(:xpath, ".//button//*/span[text()='Share']/../..").click
		puts '		LOG: sharing protocols ' + protocol_name.to_s + ' to ' + username.to_s
		find(:xpath, ".//div[@class='navigation']/button[text()='Close']").click
	end

	def transfer_ownership(username, protocol_name)
		self.focus_protocol_by_name(protocol_name)
		self.open_transfer_ownership
		find(:css, ".cb-select>input").set(username)
		find(:xpath, ".//li[@class='select-image']").click
		find(:xpath, ".//button//*/span[text()='Reassign']/../..").click
		puts '		LOG: reassign protocol... '
		find(:xpath, ".//div[@class='navigation']/button[text()='Ok']").click
	end

	def get_forked_count(protocol_name)
		return count = find_all(:xpath, ".//div[contains(@class, 'files-protocol-name') and text()='" + protocol_name + "']/i[@class='p-font pf-fork']").size
	end

	def open_view(protocol_name)
		page.driver.browser.navigate.refresh
		protocol = find(:xpath, ".//div[contains(@class, 'files-name') and text()='" + protocol_name + "']")
		manager_page = current_window
		view_page = window_opened_by do
			protocol.double_click
		end
		manager_page.close
		return ProtocolsViewPageClass.new(view_page)
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
		find(:xpath, ".//button//*/span[text()='Delete']/../..").click
	end

	def publish_protocol(flag)
		find(:xpath, ".//button[text()='Publish']").click
		find(:xpath, ".//*[@class='community-checkbox public-check'][1]").click
		find(:xpath, ".//*[@class='community-checkbox public-check'][2]").click
		if flag == "unlisted"
			find(:xpath, ".//label[@for='checkbox-share']").click
		end
		find(:xpath, ".//button//*/span[text()='Publish']/../..").click 
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

	def create_folders(folder_count, type)
		for i in 0..folder_count do
			if i == 0
				find(:xpath, ".//h3[text()='" + type + "']").right_click
				find(:xpath, ".//div[@class='ln-item' and text()='New folder']").click
				find(:xpath, ".//input[@placeholder='Name']").set("test_"+ type + i.to_s)
				find(:xpath, ".//div[@class='lightbox showElm lightbox-fade']//*/button[@class='btn btn-blue']").click
			else
				find(:xpath, ".//h3[text()='test_" + type + (i-1).to_s + "']").click
				find(:css, ".btn.new-sidebar-btn").click
				find(:xpath, ".//div[@class='ln-item' and text()='Folder']").click
				find(:xpath, ".//input[@placeholder='Name']").set("test_" + type + i.to_s)
				find(:xpath, ".//div[@class='lightbox showElm lightbox-fade']//*/button[@class='btn btn-blue']").click
			end
		end
	end
end
# end