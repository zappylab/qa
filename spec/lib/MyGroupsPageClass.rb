require 'capybara/dsl'
require_relative './base_lib.rb'

class MyGroupsPageClass
	include Capybara::DSL
	include BaseLibModule

	def search_group(group_name)
        find(:xpath, ".//*[@id='left_side']//*/li[text()='Created']").click
		find(:xpath, ".//input[@id='header-search-input']", visible: true).click
        find(:xpath, ".//input[@id='header-search-input']", visible: true).set(group_name)
        # find(:xpath, ".//input[@id='header-search-input']", visible: true).native.send_keys(:enter)
        find(:xpath, ".//div[@class='header-search-input']//*/i[@class='p-font pf-search']").click

        begin 
 			find(:xpath, ".//ul//*/a[text()='" + group_name + "']", wait: 5)
	        puts '		LOG: Searching group ' + group_name
	        puts '		LOG: Group ' + group_name + ' found'
        rescue Capybara::ElementNotFond
        	puts '		LOG: searching group again... '
        	find(:xpath, ".//div[@class='header-search-input']//*/i[@class='p-font pf-search']").click
        	find(:xpath, ".//ul//*/a[text()='" + group_name + "']", wait: 5)
        	puts '		LOG: Group ' + group_name + ' found'
        end
    end

	def drill_down_group
		find(:xpath, ".//li[contains(@class, 'gi-item')]").click
		page.has_selector?(:xpath, ".//div[@class='community-logo']")
		return ProtocolsInGroupPageClass.new
	end 
end