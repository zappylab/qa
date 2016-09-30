require 'capybara/dsl'

module GoogleEmailModule
  class GoogleEmailClass
    include Capybara::DSL
    link = 'http://je-protocols'
    # @note This method is used to confirm new account 
    # @example
    #   verify_email('protocolsuitest@gmail.com', 'protocols-ui-123', verifying)    
    def verify_email(user, pass, scenario)
      email_name = 'protocols'
      visit('https://mail.google.com/')       #navigate to gmail
      if page.has_selector?("#Email")
      elsif page.has_selector?("#account-chooser-link")
        find("#account-chooser-link").click
        find("#account-chooser-add-account").click
      elsif page.has_selector?("#account-chooser-add-account")
        find("#account-chooser-add-account").click
      end

      find('#Email').set(user)   #enter email addr
      click_button('next')                    #next
      find('#Passwd').set(pass) #enter pass
      click_button('signIn')                  #login email         
      find('#sbq').set(email_name)          #set query string to find email sbq gbqfq
      find('#sbq').native.send_keys(:enter)          #query
      xpathString = ".//font[text()='Входящие']"#.//div[@title='Входящие']"

      case scenario
      when "verifying"
        page.has_selector?(:xpath, ".//span[contains(text(), 'Your account is ready')]") 
        puts scenario + 'test1'
       when "invitation-signed"
        page.has_selector?(:xpath, ".//span[contains(text(), 'Invitation to join')]") #.//span[contains(text(), 'invited you to join')]
        puts scenario + 'test1'
      when "invitation-not-signed"
        page.has_selector?(:xpath, ".//span[contains(text(), 'Invitation to join')]")
        puts scenario + 'test1'
      end 
      title_array = page.all(:xpath, xpathString)
      puts title_array.size
      find_all(:xpath, xpathString)[0].click  #go inside mail

      case scenario
        when "verifying"
          page.has_selector?(:xpath, './/a[contains(@href, "protocols") and contains(text(), "Verify")]')
          puts scenario + 'test2'
        when "invitation-signed", "invitation-not-signed"
          page.has_selector?(:xpath, './/a[contains(@href, "protocols") and contains(text(), "Confirm")]')
          puts scenario + 'test2'
      end

      email_window = current_window
      protocols_window = window_opened_by do
        case scenario
        when "verifying"
          find(:xpath, './/a[contains(@href, "protocols") and contains(text(), "Verify")]').click
          puts scenario + 'test3'
        when "invitation-signed", "invitation-not-signed"
          find(:xpath, './/a[contains(@href, "protocols") and contains(text(), "Confirm")]').click
          puts scenario + 'test3'
        end
      end

      within_window protocols_window do
        case scenario
          when "verifying"
            # here comes actions in new window
            find(:xpath, ".//input[@class='confirm-input confirm-fn']").set(user)
            find('#ln-input').set(user)
            find(:xpath, ".//button[@class='btn btn-blue confirm-btn']").click
            page.has_selector?(:xpath, './/div[@class="ul-page"]')
            protocols_window.close
          when "invitation-signed"
            find("#confirm-group-pass-input").set(pass)
            find("#confirm-group-go-btn").click
            find(:xpath, ".//span[contains(text(), 'Confirm membership')]").click

            find(:xpath, ".//*[@class='avatar']").click
            find(:xpath, ".//span[@class='dropdown-right']/a[contains(@href, 'signout')]").click
            page.has_selector?("#app")

            protocols_window.close
          when "invitation-not-signed"
            find("#confirm-group-pass-input").set(pass)
            find("#create-confirm-group-btn").click
            xp_sign_up = ".//div[@class='success-email' and contains(text(), '" + user + "')]"
            page.has_selector?(:xpath, xp_sign_up)
            protocols_window.close
          end
      end
      switch_to_window(email_window)
      Capybara.reset_sessions!
      # page.execute_script("sessionStorage.clear();")
      # page.execute_script("localStorage.clear();")
      visit(link) 
    end
  end
end
