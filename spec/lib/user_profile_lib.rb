require 'capybara/dsl'
require_relative './base_lib.rb'

module UserProfilePageModule
	class UserProfilePageClass
		include Capybara::DSL
		include BaseLibModule
		# @note Uses to delete current account from app
		# @note User can delete from each page if header-block is visible
		# @example
		#   delete_user
		def delete_user
			find(:xpath, ".//div[@class='main-action-btn']").hover
			find_all(:xpath, ".//div[@class='action-btns']")[0].click
			find(:xpath, ".//a[@class='deleteaccount']").click
			find("#profile-delete-btn").click
			page.has_selector?("#app")
    	end
	end
end