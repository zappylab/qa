require 'capybara/dsl'

module ProtocolsStartPageModule
	module Test
		include Capybara::DSL
		# @note This method brings user to EXPLORE page
		# @example
		#   go_to_explore
		def go_to_explore
			find(:xpath, ".//div[@class='help-btns']/ul/li/i[@class='p-font pf-play-round']").click
    	end

		# @note This method brings user to PROTOCOLS page
		# @example
		#   go_to_protocols
		def go_to_protocols
			find(:xpath, ".//div[@class='help-btns']/ul/li/i[@class='p-font pf-logo']").click
    	end

		# @note This method brings user to GROPUS page
		# @example
		#   go_to_groups
		def go_to_groups
			# find(:xpath, ".//div[@class='help-btns']/ul/li/i[@class='p-font pf-public']").click #this useful if to events present on start page
			find("#groups-link-id").click
    	end

		# @note This method brings user to RESEARCHERS page
		# @example
		#   go_to_researchers
		def go_to_researchers
			find(:xpath, ".//div[@class='help-btns']/ul/li/i[@class='p-font pf-users']").click
    	end

    	def search_join_group
    		find_all(:xpath, ".//span[contains(text(), 'You are invited to join this group')]/a")[0].click
    		page.has_selector?(:xpath, ".//div[@class='community-logo']")
    	end
	end
end