# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# The generated `.rspec` file contains `--require spec_helper` which will cause
# this file to always be loaded, without a need to explicitly require it in any
# files.
#
# Given that it is always loaded, you are encouraged to keep this file as
# light-weight as possible. Requiring heavyweight dependencies from this file
# will add to the boot time of your test suite on EVERY test run, even for an
# individual file that may not need all of that loaded. Instead, consider making
# a separate helper file that requires the additional dependencies and performs
# the additional setup, and require it from the spec files that actually need
# it.
#
# The `.rspec` file also contains a few flags that are not defaults but that
# users commonly want.
#
require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'capybara'
require 'capybara/dsl'
require 'selenium/webdriver'
require 'json'
require 'os'
require 'rubygems'
require "net/http"
require "uri"
require "json"
# require 'ruby-debug'

            #connected modules#
require_relative './lib/signin_lb.rb'
require_relative './lib/signup_lb.rb'
require_relative './lib/user_profile_lib.rb'
require_relative './lib/protocols_groups_lib.rb'
require_relative './lib/protocols_ingroups_lib.rb'
require_relative './lib/protocols_start_page_lib.rb'
require_relative './lib/base_lib.rb'
require_relative './lib/protocols_editor_page.rb'
require_relative './lib/protocols_page_lib.rb'
require_relative './lib/groups_in_discussion.rb'
            #connected modules#

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration

puts "\n    OS is WINDOWS? ---> :" + OS.windows?.to_s + "\n"

Capybara::Screenshot.autosave_on_failure = false

Capybara.configure do |config|
  if ENV['browser'] == 'firefox'
    puts "    Running FIREFOX browser...\n"
    if !(OS.windows?)
      Selenium::WebDriver::Firefox::Binary.path = "/usr/bin/firefox"
    end

    Capybara.register_driver :selenium do |app|
      profile = Selenium::WebDriver::Firefox::Profile.new
      profile['browser.privatebrowsing.autostart'] = true
      Capybara::Selenium::Driver.new(app, :browser => :firefox, :profile => profile) #:profile => profile
    end
  elsif ENV['browser'] == 'chrome'
          puts "\n    Running CHROME browser...\n"
    if(OS.windows?)
      Selenium::WebDriver::Chrome.driver_path = "../ChromeDriver/chromedriver.exe"
      puts "\n    Using ChromeDriver for WINDOWS...\n"
    else
      Selenium::WebDriver::Chrome.driver_path = "../../chromedriver"
      puts "\n    Using ChromeDriver for LINUX...\n"
    end
    if !(OS.windows?)
      Selenium::WebDriver::Chrome.path = "/usr/bin/google-chrome"
    end
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :chrome, args: ["--start-maximized --incognito"])
    end
  end
  Capybara.default_max_wait_time = 25
  config.run_server = false
  config.default_driver = :selenium
  config.app_host = 'https://www.google.com' # change url
end

RSpec.configure do |config|
  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|

            #connected modules#
  config.include BaseLibModule
            #connected modules#

  config.include Capybara::DSL

  config.before(:each) do
      page.driver.browser.manage.timeouts.page_load = 100
      if OS.windows?
        page.driver.browser.manage.window.maximize
      else 
        if ENV['browser'] == 'firefox'
          page.driver.browser.manage.window.maximize
        end
        # page.driver.browser.manage.window.resize_to(1280, 1024)
        # page.driver.browser.manage.window.move_to(0, 0)
      end

     Capybara.reset_sessions!
     Capybara.current_session.driver.browser.manage.delete_all_cookies
  end
  aggregated_error_str = ""

  config.after(:each) do |example|
    if example.exception
      example_name = "EXAMPLE NAME: " + example.description.to_s + "\n"
      example_class = "EXAMPLE CLASS: " + example.exception.class.to_s + "\n"
      example_message = "EXAMPLE MESSAGE: " + example.exception.message.to_s + "\n"
      backtrace_array =  example.exception.backtrace
      backtrace_string = "BACKTRACE: \n" + backtrace_array[5] + "\n" + backtrace_array[6]
      aggregated_error_str = aggregated_error_str + "\n" + example_name + example_class + example_message + backtrace_string + "\n\n\n"

      screenshot_name = example.description
      page.save_screenshot(screenshot_name + ".png")
    end

    Capybara.reset_sessions!
    Capybara.current_session.driver.browser.manage.delete_all_cookies
    errors = page.driver.browser.manage.logs.get(:browser)
    if errors.length > 0
      message = errors.map(&:message).join("\n\n")
      puts message
    end
  end

  config.after(:all) do
    puts aggregated_error_str
  end

  # config.before(:all) do

  # end
  
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end
