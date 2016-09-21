require 'capybara/dsl'

module ProtocolsInGroupModule
	module Test
		include Capybara::DSL
		# @note This method brings user to EXPLORE page
		# @example
		#   go_to_explore
		def delete_group
			find(:xpath, ".//div[@class='main-action-btn']").hover
			find(:xpath, ".//div[@class='ab-round']/i[@class='p-font pf-gear']").click
			script = "arguments[0].scrollIntoView(true);"
			element = page.all(:xpath, ".//a[@class='deleteaccount']", :all)[0]
			Capybara.current_session.driver.browser.execute_script(script, element.native)
			element.click
			find("#delete-group-btn").click
			page.has_selector?("#s-mce-img")
		end

		def accept_invite
			find(:xpath, ".//span[contains(text(), 'Confirm membership')]").click
		end
	end
end