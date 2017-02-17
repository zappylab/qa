require 'capybara/dsl'
require_relative './base_lib.rb'
require_relative './core.rb'

# module LoginPageModule
class LoginPageClass
  include Capybara::DSL
  include BaseLibModule
  include Finders
  # $link =  'http://je-protocols' #'http://sience:awesome@dev.protocols.io/'
  # def get_link
  $link = ENV['link']
  # end
  # @param email [String] email for account to login in app
  # @param pass [String] password for account to login in app
  # @note Each test scenario starts with login in app
  # @example
  #   sign_in('protocolsuitest@gmail.com', 'protocols-ui-123')
  def sign_in(email, pass)
    puts "\n    VISITING LINK ---> " + $link.to_s + "\n"
    visit($link)
    find('#sign-in-header').click
    # page.has_selector?(:xpath, ".//div[@class='signin-window']")
    # find_all(:xpath, ".//ul[@class='sign-radio radio noselect']/li")[1].click
    puts "\n    Logging in as : " + email + "\n"
    find(:xpath, './/input[@id="email"]').set(email)
    find(:xpath, './/input[@id="pass"]').set(pass)
    # find(:xpath, './/div[@class="sign-btn"]').click
    find_by_class('btn btn-create').click
    page.has_selector?(:xpath, './/div[@class="ul-page"]')
    return ProtocolsStartPageClass.new;
  end

  # @param email [String] account's email using to sign up the app
  # @param pass [String] account's password using to sign up the app
  # @note Uses to sign up into the app and start a new protocols account
  # @example
  #   sign_up('protocolsuitest@gmail.com', 'protocols-ui-123')
  def sign_up(email, pass)
    visit($link)
    puts "\n    VISITING LINK ---> " + $link + "\n"
    begin
      find(:css, '#sign-up-header', wait: 5);
      find(:xpath, './/input[@id="email"]').set(email)
      find(:xpath, './/input[@id="pass"]').set("protocols-ui-123")
      find(:xpath, './/button[@class="btn btn-create"]').click
      page.has_selector?(:css, ".ca-form")
    rescue(Capybara::ElementNotFound)
      element = find_by('input', '', 'type', 'email');
      element.set(email)
      find_by('input', '', 'type', 'password').set(pass)
      find_by_class("btn btn-blue btn-welcome-signup").click
      find_by('div', '', 'class', 'sp-right-row');
      sleep 5.0;
    end
    puts "\n    Signed up as : " + email + "\n"
  end
end
# end

  # tag_name, id, attribute, attribute text, InnerHTML
  # def find_by(*args)
# t = MyCapybaraTest::Test.new
# t.test_sign_in_app
