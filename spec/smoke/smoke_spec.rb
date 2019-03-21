require 'spec_helper'

RSpec.feature 'Check health endpoint' do
  scenario 'returns a status message from the health endpoint' do
    start_page = ENV.fetch('PRODUCTION_START_PAGE') + '/health'
    visit start_page

    expect(page).to have_content('Everything is fine.')
  end
end

RSpec.feature 'Smoke test' do
  scenario 'can successfully visit all the pages' do
    root = ENV.fetch('PRODUCTION_START_PAGE')

    sign_in_and_go_production root

    expect(page).to have_css('.govuk-heading-xl', text: 'Dashboard')

    visit root + "/summary/allocated"

    expect(page).to have_css('.govuk-breadcrumbs__link', text: 'See allocations')

    visit root + "/summary/unallocated"

    expect(page).to have_css('.govuk-breadcrumbs__link', text: 'Make allocations')

    visit root + "/summary/pending"

    expect(page).to have_css('.govuk-breadcrumbs__link', text: 'Update information')

    visit root + "/poms/my_caseload"

    expect(page).to have_css('.govuk-breadcrumbs__link', text: 'Your caseload')

    visit root + "/poms/new_cases"

    expect(page).to have_css('.govuk-breadcrumbs__link', text: 'New cases')

    visit root + "/poms"

    expect(page).to have_css('.govuk-breadcrumbs__link', text: 'Prison Offender Managers')
  end
end


