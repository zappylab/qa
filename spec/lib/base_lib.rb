require 'capybara/dsl'

module BaseLibModule
    include Capybara::DSL
    # @note This method is used to log out from the app
    # @example
    #   sign_in
    def sign_out
		find(:xpath, ".//*[@class='avatar']").click
		find(:xpath, ".//span[@class='dropdown-right']/a[contains(@href, 'signout')]").click
		page.has_selector?("#app")
		return LoginPageModule::LoginPageClass.new
    end

    def go_to_user_profile
		find(:xpath, ".//*[@class='avatar']").click
		find(:xpath, ".//*[@class='dh-right']").click
		page.has_selector?("#app")
		return UserProfilePageModule::UserProfilePageClass.new
    end

    def go_to_your_protocols
    	find(:xpath, ".//*[@class='avatar']").click
    	find(:xpath, ".//*[@class='dropdown-right']/a[contains(text(), 'protocol')]").click
    	return ProtocolsPageModule::ProtocolsPageClass.new
    end
end