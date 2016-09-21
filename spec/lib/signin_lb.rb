require 'capybara/dsl'

module SignInModule
  module Test
    include Capybara::DSL

    # @param email [String] email for account to login in app
    # @param pass [String] password for account to login in app
    # @note Each test scenario starts with login in app
    # @example
    #   sign_in('protocolsuitest@gmail.com', 'protocols-ui-123')
    def sign_in(email, pass)
      visit('http://je-protocols')
      click_link('sign-in-header')
      find(:xpath, './/input[@id="email"]').set(email)
      find(:xpath, './/input[@id="pass"]').set(pass)
      find(:xpath, './/div[@class="sign-btn"]').click
      page.has_selector?(:xpath, './/div[@class="ul-page"]')
    end
  end
end


# t = MyCapybaraTest::Test.new
# t.test_sign_in_app
