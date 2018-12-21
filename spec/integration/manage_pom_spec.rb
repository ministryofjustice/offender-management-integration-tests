require 'spec_helper'

RSpec.feature 'POM management' do
  scenario 'editing a POMs' do
    sign_in_and_go ENV.fetch('START_PAGE')
    expect(page).to have_content('Dashboard')

    click_on("Active POMs")
    expect_breadcrumbs(2)
    expect(page).to have_content('Prison Offender Managers')
    expect(page).to have_css('.govuk-tabs__list-item', count: 2)

    page.first(:link, "View").click
    expect_breadcrumbs(3)
    expect(page).to have_content('POM level')
    expect(page).to have_content('Working pattern')

    find('.govuk-button').click
    expect_backlink
    expect(page).to have_content('Edit profile')

    # The actual radio buttons we want here aren't visible because of how the
    # design scheme works.
    find('#working-pattern-1', :visible => false).choose
    find('#working-status-1', :visible => false).choose
    click_button('Save')
  end
end
