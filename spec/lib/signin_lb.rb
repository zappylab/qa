require 'capybara/dsl'

module LoginPageModule
  class LoginPageClass
    include Capybara::DSL
    link = 'http://je-protocols'
    # @param email [String] email for account to login in app
    # @param pass [String] password for account to login in app
    # @note Each test scenario starts with login in app
    # @example
    #   sign_in('protocolsuitest@gmail.com', 'protocols-ui-123')
    def sign_in(email, pass)
      visit(link)
      click_link('sign-in-header')
      find(:xpath, './/input[@id="email"]').set(email)
      find(:xpath, './/input[@id="pass"]').set(pass)
      find(:xpath, './/div[@class="sign-btn"]').click
      page.has_selector?(:xpath, './/div[@class="ul-page"]')
      return ProtocolsStartPageModule::ProtocolsStartPageClass.new;
    end

    # @param email [String] account's email using to sign up the app
    # @param pass [String] account's password using to sign up the app
    # @note Uses to sign up into the app and start a new protocols account
    # @example
    #   sign_up('protocolsuitest@gmail.com', 'protocols-ui-123')
    def sign_up(email, pass)
      visit(link)
      click_link('sign-up-header')
      find(:xpath, './/input[@id="email"]').set(email)
      find(:xpath, './/input[@id="pass"]').set("protocols-ui-123")
      find(:xpath, './/button[@class="btn btn-create"]').click
      page.has_selector?(:xpath, './/div[@class="ul-page"]')
    end
  end
end


# t = MyCapybaraTest::Test.new
# t.test_sign_in_app
