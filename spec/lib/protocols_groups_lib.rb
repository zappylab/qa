require 'capybara/dsl'
require_relative './base_lib.rb'
require 'time'

# module ProtocolsGroupPageModule 
class ProtocolsGroupPageClass
	include Capybara::DSL
	include BaseLibModule
	# @note This method brings user to EXPLORE page
	# @example
	#   create_group
	def create_group
		find(:xpath, ".//span[@class='add-content-icon cc-block-inline']/i[@class='p-font pf-plus']").click
		page.has_selector?("#save-group-btn")
	end

	# @param name [String] NAME of created group
	# @note This method fills group's NAME
	# @example
	#   fill_group_name("testGroupName")
	def fill_group_name(name)
		$name = name+Time.now.nsec.to_s
		element = find(:xpath, ".//div[@class='create-name']/input")
		element.send_keys($name)
		element.set("")
		script = "arguments[0].value = '" + $name + "';"
		Capybara.current_session.driver.browser.execute_script(script, element.native)
		queryString = ".//div[@class='create-name']/span[contains(text(), '" + $name.downcase + "')]"
		find(:xpath, ".//div[@class='create-name']/label").click
		page.has_selector?(:xpath, queryString)
		return $name
	end

	# @param text [String] textn in ABOUT field of created group
	# @note This method fills group's ABOUT field
	# @example
	#   fill_about_text("testText")
	def fill_about_text(text)
		within_frame 'add-group-mce_ifr' do
			find(:xpath, ".//body[@id='tinymce']").click
			find(:xpath, ".//body[@id='tinymce']").set(text)
		end
	end

	# @param interest [String] text in INTEREST field of created group
	# @note This method fills group's INTEREST field
	# @example
	#   fill_interest("testInterest")
	def fill_interest(interest)
		page.all(:xpath, ".//div[@class='create-block']/div[@class='block-data']/input")[0].set(interest)
	end

	# @param site [String] text in WEBSITE field of created group
	# @note This method fills group's WEBSITE field
	# @example
	#   fill_website("testWebSite")
	def fill_website(site)
		page.all(:xpath, ".//div[@class='create-block']/div[@class='block-data']/input")[1].set(site)
	end

	# @param location [String] text in LOCATION field of created group
	# @note This method fills group's LOCATION field
	# @example
	#   fill_location("location")
	def fill_location(location)
		page.all(:xpath, ".//div[@class='create-block']/div[@class='block-data']/input")[2].set(location)
	end

	# @param location [String] text in AFFILATION field of created group
	# @note This method fills group's AFFILATION field
	# @example
	#   fill_affilation("affilation")
	def fill_affilation(affilation)
		page.all(:xpath, ".//div[@class='create-block']/div[@class='block-data']/input")[3].set(affilation)
	end

	# @param accsess [String] this parameter defines which class of invitation is used to invite use: "invitation", "membership", "anyone" strings
	# @note This method checks one of invitation radios
	# @example
	#   set_group_access("invitation")
	#   set_group_access("membership")
	# =>set_group_access("anyone")
	def set_group_access(accsess)
		case accsess
		when "invitation"
			element = page.all(:xpath, ".//ul[@class='radio']")[0].all(:xpath, ".//li")[0].click
		when "membership"
			page.all(:xpath, ".//ul[@class='radio']")[0].all(:xpath, ".//li")[1].click
		when "anyone"
			page.all(:xpath, ".//ul[@class='radio']")[0].all(:xpath, ".//li")[2].click
		end
	end

	# @param accsess [Boolean] this parameter defines visibility of group
	# @note This method checks one of visibility radios
	# @example
	#   set_group_visibility(true)
	def set_group_visibility(visibility)
		if visibility
			page.all(:xpath, ".//ul[@class='radio']")[1].all(:xpath, ".//li")[0].click
		else
			page.all(:xpath, ".//ul[@class='radio']")[1].all(:xpath, ".//li")[2].click
		end
	end

	# @param accsess [String] this parameter defines user's email to invite into group
	# @note This method sets emain into INVITE MEMBER field
	# @example
	#   invite_people("someone@email.com")
	def invite_people(email)
		find(:xpath, ".//div[@class='block-data invite-users']/input").set(email)
	end

	# @note This method clicks button to SAVE group
	# @example
	#   save_group
	def save_group
		find("#save-group-btn").click
		page.has_selector?(:xpath, ".//div[@class='community-overview']//*/span[contains(text(),'" + $name + "')]")
		puts 'Group' + $name + 'located'
		return ProtocolsInGroupPageClass.new
	end

	def find_group(group_name)
		# find("#header-search-input").set(group_name) this is for je-protocols
		# find("#header-search-input").native.send_keys(:enter)
		puts 'Searching group ' + group_name 
		seach_link = ENV['link'] + "/search?key=" + group_name
		visit(seach_link)

		page.has_selector?(:xpath, ".//ul[@class='community-search-groups']")# if noSuchElementLocated -> searchResult=null
	end

	def drill_down_group
		find(:xpath, ".//ul[@class='community-search-groups']/li").click
		page.has_selector?(:xpath, ".//div[@class='community-logo']")
		return ProtocolsInGroupPageClass.new
	end
end
# end


# Capybara.current_session.driver.browser.execute_script(script, element.native)
# arguments[0].scrollIntoView(true);