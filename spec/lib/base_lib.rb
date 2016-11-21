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

    def go_to_my_protocols
        find(:xpath, ".//a[@href='/view']").click
        page.has_selector?(:xpath, ".//div[@class='files-manager']")
        return MyProtocolsPageClass.new
    end

    $er_cnt = 0
    def find_delete_link
            find(:xpath, "//*[@class='profile-btns noselect']/button[2]").click
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

    def create_group
        find(:xpath, ".//div[@class='user-menu-toggle']/i[@class='p-font pf-plus']").click
        groups_window = window_opened_by do
            find(:xpath, ".//a[@href='/groups/create' and @target='_blank']").click
        end
        current_window.close
        switch_to_window(groups_window)
        return ProtocolsGroupPageClass.new
    end

    def go_to_my_groups
        find(:xpath, ".//*[@class='avatar']").click
        find(:xpath, ".//a[text()='My groups']").click
        return MyGroupsPageClass.new
    end
end