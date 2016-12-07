require 'capybara/dsl'
require_relative './base_lib.rb'
require 'time'

class RunProtocolsPageClass
	include BaseLibModule
	@active_step 		= nil
	@checked_steps 		= nil
	@step_count 		= nil
	@last_active_numb 	= nil

	def initialize
		self.init
	end

	def init
		active_step_xpath = ".//*[@class='list-of-step']/div[1]"
		@active_step = find(:xpath, active_step_xpath)
		@active_step_numb = 1
		@step_count = find_all(:xpath, ".//div[contains(@class, 'step-list-item') and not(contains(@class, 'stub-item'))]").size
		@checked_steps = Array.new(find_all(:xpath, ".//div[contains(@class, 'step-list-item') and not(contains(@class, 'stub-item'))]").size, false)
		begin
			@last_active_numb = find_all(:xpath, "//*/*[@class='run-checkbox checked']").size
			for i in 0..@last_active_numb-1 do
				@checked_steps[i] = true
				puts @checked_steps[i].to_s
			end
		rescue Capybara::ElementNotFound
			@last_active_numb = 0
		end	
	end

	def default_focus
		self.focus_step(@last_active_numb+1)
	end

	def focus_step(step_number)
		@active_step = find(:xpath, ".//*[@class='list-of-step']/div[" + step_number.to_s + "]")
		@active_step.click
		active_step_numb = step_number
	end

	def check_step
		@active_step.find_all(:xpath, "//*/*[@class='run-checkbox']")[@active_step_numb-1].click
		@checked_steps[@active_step_numb-1] = true
		@last_active_numb = @last_active_numb + 1 
	end

	def uncheck_step
		@active_step.find_all(:xpath, "//*/*[@class='run-checkbox checked']")[@active_step_numb-1].click
		@checked_steps[@active_step_numb-1] = false
		@last_active_numb = @last_active_numb - 1
	end

	def skip_step
		find(:xpath, ".//*[@class='step-window-nav']/*[@title='Skip step']").click
		@checked_steps[@active_step_numb-1] = true
		@last_active_numb = @last_active_numb + 1
	end

	def open_edit_step
		find_all(:xpath, ".//i[contains(@class, 'step-nav-item')]")[0].click
	end

	def edit_step_desc(text)
		find(:xpath, ".//*[@class='cb-select select-soft']/input").click
		Capybara.current_session.driver.browser.action.send_keys(:page_up).perform
		iframe = find(:xpath, ".//iframe")
		within_frame iframe do
			find(:css, "#tinymce").set('')
			find(:css, "#tinymce").set(text)
		end
		# save step record
		self.save_step_record
	end

	def edit_step_protocol(protocol_name)
		find(:xpath, ".//*[@class='cb-select select-protocol']/input").set(protocol_name)
		find(:xpath, ".//*[@class='showElm']/ul/li[1]").click
		self.save_step_record
	end

	def remove_protocol
		find(:xpath, ".//*[@class='small-title' and text()='Protocol']/preceding-sibling::i").click
		self.save_step_record
	end

	def save_in_journal(project_name)
		find(:xpath, ".//button[text()='save in journal']").click
		find(:xpath, ".//*[@class='cb-select']/input").set(project_name)
		find(:xpath, ".//*[@class='showElm']/ul/li/div/b[text()='" + project_name + "']").click
		find(:xpath, ".//*[@class='navigation']/button[2]").click
	end

	def view_journal
		cur_window = Capybara.current_window
		journal_window = window_opened_by do
			find(:xpath, ".//*[@class='btn-list']/a").click
		end
		cur_window.close
		switch_to_window(journal_window)
		return JournalProtocolsPageClass.new
	end

	def save_step_record
		find(:xpath, ".//div[@class='nav']/button[text()='save']").click
	end

# GETTERS

	def get_checked_steps
		return @checked_steps
	end

	def get_active_step
		return @active_step
	end

end