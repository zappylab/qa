require 'capybara/dsl'

# module ProtocolsInGroupPageModule
class ProtocolsInGroupPageClass
	include Capybara::DSL
	include BaseLibModule
	# @note This method brings user to EXPLORE page
	# @example
	#   go_to_explore
	def delete_group
		find(:xpath, ".//*[text()='Edit group profile']/..").click
		element = page.all(:xpath, ".//a[@class='deleteaccount']", :all)[0]
		# Capybara.current_session.driver.browser.execute_script(script, element.native)
		element.click
		find("#delete-group-btn").click
		page.has_selector?("#s-mce-img")
	end

	def accept_invite
		find(:xpath, ".//span[contains(text(), 'Confirm membership')]").click
	end

	def add_discussion(title, text)
		find(:xpath, ".//div[@class='slider show']/input").set(title)
		t_mce_frame = find(:xpath, ".//div[@class='wrap tinymce-block']//*/iframe[@id='add-thread-mce_ifr']")
		within_frame t_mce_frame do
			find("#tinymce").set(text)
		end
		find(:xpath, ".//div[@class='add-nav']/button[@class='button blue-bg']").click
		page.has_selector?(:xpath, ".//div[@class='th-main']//*/*[text()='" +
			title + "' or text()='" + 
				text +"']")
		return GroupsInDiscussionPageClass.new
	end

	def go_to_discussion_page(discussion_name)
		find(:xpath, ".//ul[@class='community-group-discussions threads-list']
			//*/a[@title='" + discussion_name +"']").click
		return GroupsInDiscussionPageClass.new
	end

	def click_commutiny_menu_item(item_name)
		find(:xpath, ".//div[@class='community-menu']/ul/li/span[contains(text(), '"+ item_name +"')]/..").click
	end

	def click_plus_button_on_item(item_name)
		find(:css, ".title")
		while true do
			if (page.evaluate_script('jQuery.active == 0').to_s == "true")
				break;
			end
		end

		e = find(:xpath, ".//*[@class='inside-title' and text()='Research interests']");
		scroll_to_element(e)
		e1 = find(:xpath, ".//h2[@class='community-content-title' and text()='" +
			item_name + "']//*/i")
		e1.click
	end
end
# end