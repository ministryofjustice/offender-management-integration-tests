module Helpers
    module Breadcrumbs
      def expect_breadcrumbs(count)
        expect(page).to have_css('.govuk-breadcrumbs__link', count: count)
      end

      def expect_backlink()
        expect(page).to have_css('.govuk-back-link', count: 1)
      end
    end
  end