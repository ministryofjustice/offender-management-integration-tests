# frozen_string_literal: true

require 'spec_helper'

RSpec.feature 'POM management' do
  scenario 'editing a POMs' do
    sign_in_and_go_staging ENV.fetch('STAGING_START_PAGE')
    expect(page).to have_content('Dashboard')

    click_on('View all offender managers')
    expect_breadcrumbs(2)
    expect(page).to have_content('Prison Offender Managers')
    expect(page).to have_css('.govuk-tabs__list-item', count: 2)

    page.first(:link, 'View').click
    expect_breadcrumbs(3)
    expect(page).to have_content('POM level')
    expect(page).to have_content('Working pattern')

    find('.govuk-button').click
    expect_backlink
    expect(page).to have_content('Edit profile')
  end
end
