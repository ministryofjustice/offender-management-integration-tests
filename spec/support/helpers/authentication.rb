module Helpers
    module Authentication
      def sign_in_and_go(url)
        visit url

        expect(page).to have_content('Username')
        expect(page).to have_content('Password')

        fill_in 'Username', with: ENV.fetch('STAFF_USERNAME')
        fill_in 'Password', with: ENV.fetch('STAFF_PASSWORD')

        click_button('Sign in')
      end
    end
  end