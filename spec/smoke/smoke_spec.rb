require 'spec_helper'

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

    visit root + "/poms"

    expect(page).to have_css('.govuk-breadcrumbs__link', text: 'Prison Offender Managers')
  end
end
