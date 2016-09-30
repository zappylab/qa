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
			# page.execute_script "document.getElementsByClassName('lighbox-Settings')[0].scrollBy(0,10000)"
			script = "arguments[0].scrollIntoView(true);"
			element = page.all(:xpath, ".//a[@class='deleteaccount']", :all)[0]
			Capybara.current_session.driver.browser.execute_script(script, element.native)
			element.click
			# find(:css, ".deleteaccount").click
			find("#profile-delete-btn").click
			page.has_selector?("#app")
    	end
	end
end