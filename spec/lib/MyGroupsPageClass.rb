require 'capybara/dsl'
require_relative './base_lib.rb'

class MyGroupsPageClass
	include Capybara::DSL
	include BaseLibModule

	def search_group(group_name)
        find("#header-search-input").set(group_name)
        find("#header-search-input").native.send_keys(:enter)
        puts '		LOG: Searching group ' + group_name
        find(:xpath, ".//ul[@class='community-search-groups']//*/a[@class='gi-name' and text()='" + group_name + "']")
        puts '		LOG: Group ' + group_name + ' found'
    end

	def drill_down_group
		find(:xpath, ".//ul[@class='community-search-groups']/li").click
		page.has_selector?(:xpath, ".//div[@class='community-logo']")
		return ProtocolsInGroupPageClass.new
	end 
end