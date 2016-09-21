require 'capybara/dsl'

module UserProfileModule
	module Test
		include Capybara::DSL
		# @note Uses to delete current account from app
		# @note User can delete from each page if header-block is visible
		# @example
		#   delete_user
		def delete_user
			find(:xpath, ".//*[@class='avatar']").click
			find(:xpath, ".//*[@class='dh-right']").click
			find(:xpath, ".//div[@class='main-action-btn']").hover
			page.all(:xpath, ".//div[@class='ab-round']/i")[0].click
			page.execute_script "document.getElementsByClassName('lighbox-Settings')[0].scrollBy(0,10000)"
			find(:css, ".deleteaccount").click
			find("#profile-delete-btn").click
			page.has_selector?("#app")
    	end
	end
end