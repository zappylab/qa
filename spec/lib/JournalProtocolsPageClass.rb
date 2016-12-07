require 'capybara/dsl'
require_relative './base_lib.rb'
require 'time'

class JournalProtocolsPageClass
	include BaseLibModule
	def initialize	
		self.init
	end

	def init
		begin
			find(:xpath, ".//div[@class='protocol-img']")
			completed = find_all(:xpath, ".//*[@class='ji-block']")
			@completed_steps = completed.size
		rescue Capybara::ElementNotFound
			@completed_steps = 0
		end
	end

	def get_completed_steps
		return @completed_steps
	end

	def resume_protocol
		begin
			currnet_page = Capybara.current_window
			runPage = window_opened_by do
				find(:xpath, ".//a[text()='Resume']").click
			end
			puts '		LOG: resume protocol run... '
			current_window.close
			switch_to_window(runPage)
			return RunProtocolsPageClass.new
		rescue Capybara::ElementNotFound
			puts "		LOG: can't find resume link..."
			fail
		end
	end
end