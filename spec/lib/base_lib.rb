require 'capybara/dsl'

module BaseLibModule
    include Capybara::DSL
    # @note This method is used to log out from the app
    # @example
    #   sign_in
    def sign_out
        # puts '  find avatar   ' + (Time.now).strftime("%H:%M:%S")
		find(:xpath, ".//*[@class='avatar']").click
        # find(:xpath, ".//span[@class='dropdown-right']/a[contains(@href, '/signout')]").click
		find(:xpath, ".//span[@class='dropdown-right']/a[contains(text(), 'Sign out')]").click
		page.has_selector?("#app")
		return LoginPageClass.new
    end

    def go_to_user_profile
		find(:xpath, ".//*[@class='avatar']").click
		find(:xpath, ".//*[@class='dh-right']").click
		page.has_selector?("#app")
		return UserProfilePageClass.new
    end

    def go_to_your_protocols
    	find(:xpath, ".//*[@class='avatar']").click
    	find(:xpath, ".//*[@class='dropdown-right']/a[contains(text(), 'protocol')]").click
    	return ProtocolsPageClass.new
    end

    def go_to_your_protocols
        find(:xpath, ".//li/a[text()='Your protocols']").click
        page.has_selector?(:xpath, ".//div[@class='files-manager']")
        return ProtocolsIoPageClass.new
    end

    $er_cnt = 0
    def find_delete_link
        find(:xpath, ".//div[@class='main-action-btn']").hover
        find_all(:xpath, ".//div[@class='action-btns']")[0].click
        begin
            $link_element = find("#delete-acc-link", wait: 5)
            $link_element.click
        rescue Capybara::ElementNotFound, NoMethodError
            puts '  Refreshing user profile page ---> searching delete link once again = ' + $er_cnt.to_s
            page.driver.browser.navigate.refresh
            $er_cnt += 1
            if($er_cnt < 5)
                self.find_delete_link
            else
                puts "Tried to find DELETE LINK for " + $er_cnt.to_s + " times... No result..." 
                fail
            end
        end
    end

    def scroll_to_element(element)
        script = "arguments[0].scrollIntoView(true);"
        Capybara.current_session.driver.browser.execute_script(script, element.native)
    end
end