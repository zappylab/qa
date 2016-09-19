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
    def verify_email
      email_name = 'protocols'

      visit('https://mail.google.com/')       #navigate to gmail
      find('#Email').set('protocolsuitest')   #enter email addr
      click_button('next')                    #next
      find('#Passwd').set('protocols-ui-123') #enter pass
      click_button('signIn')                  #login email         
      find('#gbqfq').set(email_name)          #set query string to find email
      find('#gbqfq').native.send_keys(:enter)          #query
      xpathString = ".//div[@title='Входящие']"

      title_array = Array.new
      page.has_selector?(:xpath, ".//span[contains(text(), 'Your account is ready')]")
      title_array = page.all(:xpath, xpathString)
      puts page.all(:xpath, xpathString).size
      page.all(:xpath, xpathString)[0].click

      page.has_selector?(:xpath, './/a[contains(@href, "protocols") and contains(text(), "Verify")]')
      email_window = current_window
      protocols_window = window_opened_by do
        find(:xpath, './/a[contains(@href, "protocols") and contains(text(), "Verify")]').click
      end

      within_window protocols_window do
        # here comes actions in new window
        find(:xpath, ".//input[@class='confirm-input confirm-fn']").set("testFirstName")
        find('#ln-input').set("testLastName")
        find(:xpath, ".//button[@class='btn btn-blue confirm-btn']").click
        page.has_selector?(:xpath, './/div[@class="ul-page"]')
        protocols_window.close
      end

      switch_to_window(email_window)
      visit('http://je-protocols')
      # Capybara.reset_sessions!  
    end
  #method to delete active acc
    def delete_user(user, pass)
      visit('http://je-protocols')
      find(:xpath, ".//*[@class='avatar']").click
      find(:xpath, ".//*[@class='dh-right']").click
      find(:xpath, ".//div[@class='main-action-btn']").hover
      page.all(:xpath, ".//div[@class='ab-round']/i")[0].click
      page.execute_script "document.getElementsByClassName('lighbox-Settings')[0].scrollBy(0,10000)"
      find(:css, ".deleteaccount").click
      find("#profile-delete-btn").click
      page.has_selector?("#app")
    end

  end
end
