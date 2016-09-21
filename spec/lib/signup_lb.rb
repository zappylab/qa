require 'capybara/dsl'

module SignUpModule
  module Test
    include Capybara::DSL

    # @param email [String] account's email using to sign up the app
    # @param pass [String] account's password using to sign up the app
    # @note Uses to sign up into the app and start a new protocols account
    # @example
    #   sign_up('protocolsuitest@gmail.com', 'protocols-ui-123')
    def sign_up(email, pass)
      visit('http://je-protocols')
      click_link('sign-up-header')
      find(:xpath, './/input[@id="email"]').set(email)
      find(:xpath, './/input[@id="pass"]').set("protocols-ui-123")
      find(:xpath, './/button[@class="btn btn-create"]').click
      page.has_selector?(:xpath, './/div[@class="ul-page"]')
    end

    # @note This method is used to confirm new account 
    # @example
    #   sign_up('protocolsuitest@gmail.com', 'protocols-ui-123')    
    def verify_email(user, pass, scenario)
      email_name = 'protocols'
      visit('https://mail.google.com/')       #navigate to gmail
      if page.has_selector?("#account-chooser-link")
        find("#account-chooser-link").click
        find("#account-chooser-add-account").click
      end
      find('#Email').set(user)   #enter email addr
      click_button('next')                    #next
      find('#Passwd').set(pass) #enter pass
      click_button('signIn')                  #login email         
      find('#gbqfq').set(email_name)          #set query string to find email
      find('#gbqfq').native.send_keys(:enter)          #query
      xpathString = ".//div[@title='Входящие']"

      title_array = Array.new
      case "verifying"
      when
        page.has_selector?(:xpath, ".//span[contains(text(), 'Your account is ready')]")
      when
        page.has_selector?(:xpath, ".//span[contains(text(), 'invited you to join')]")
      end 
      # title_array = page.all(:xpath, xpathString)
      page.all(:xpath, xpathString)[0].click  #go inside mail

      case scenario
      when "verifying"
        page.has_selector?(:xpath, './/a[contains(@href, "protocols") and contains(text(), "Verify")]')
      when "invitation"
        page.has_selector?(:xpath, './/a[contains(@href, "protocols") and contains(text(), "Confirm")]')
      end

      email_window = current_window
      protocols_window = window_opened_by do
        case scenario
        when "verifying"
          find(:xpath, './/a[contains(@href, "protocols") and contains(text(), "Verify")]').click
        when "invitation"
          find(:xpath, './/a[contains(@href, "protocols") and contains(text(), "Confirm")]').click
        end
      end

      within_window protocols_window do
        case scenario
        when "verifying"
          # here comes actions in new window
          find(:xpath, ".//input[@class='confirm-input confirm-fn']").set("testFirstName")
          find('#ln-input').set("testLastName")
          find(:xpath, ".//button[@class='btn btn-blue confirm-btn']").click
          page.has_selector?(:xpath, './/div[@class="ul-page"]')
          protocols_window.close
        when "invitation"
          # find(:xpath, ".//div[@class='group-item']").click
          # page.has_selector?(:xpath, ".//div[@class='community-logo']")
          protocols_window.close
        end
      end

      switch_to_window(email_window)
      page.execute_script("sessionStorage.clear();")
      page.execute_script("localStorage.clear();")
      # visit('http://je-protocols') 
    end
  end
end
