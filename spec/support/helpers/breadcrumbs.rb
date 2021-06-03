# frozen_string_literal: true

module Helpers
  module Breadcrumbs
    def expect_breadcrumbs(count)
      expect(page).to have_css('.govuk-breadcrumbs__link', count: count)
    end

    def expect_backlink
      expect(page).to have_css('.govuk-back-link', count: 1)
    end

    def wait_for(maximum_wait_in_seconds = 20)
      Selenium::WebDriver::Wait.new(timeout: maximum_wait_in_seconds).until { yield }
    end
  end
end
