# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize
module Helpers
  module Authentication
    def sign_in_and_go_staging(url)
      visit url

      if page.has_content?('Sign in', wait: 5)
        # We've been redirected to HMPPS Auth. We need to sign in.
        expect(page).to have_content('Username')
        expect(page).to have_content('Password')

        fill_in 'Username', with: ENV.fetch('STAGING_STAFF_USERNAME')
        fill_in 'Password', with: ENV.fetch('STAGING_STAFF_PASSWORD')

        click_button('Sign in')
      else
        # Otherwise, expect to see a "Sign out" link on the page.
        expect(page).to have_link('Sign out')
      end
    end

    def sign_in_and_go_production(url)
      visit url
      return if page.has_link?('Sign out')

      expect(page).to have_content('Username')
      expect(page).to have_content('Password')

      fill_in 'Username', with: ENV.fetch('PRODUCTION_STAFF_USERNAME')
      fill_in 'Password', with: ENV.fetch('PRODUCTION_STAFF_PASSWORD')

      click_button('Sign in')
    end
    # rubocop:enable Metrics/AbcSize
  end
end
