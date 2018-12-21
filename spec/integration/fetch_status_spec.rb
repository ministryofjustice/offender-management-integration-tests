require 'spec_helper'

RSpec.feature 'Fetching the status' do
  scenario 'returns a status message from the health endpoint' do
    start_page = ENV.fetch('START_PAGE') + '/health'

    visit start_page

    expect(page).to have_content('Everything is fine.')
  end

  scenario 'returns the database status from the allocation api' do
    start_page = ENV.fetch('START_PAGE') + '/status'
    sign_in_and_go(start_page)

    expect(page).to have_css('.status', text: 'ok')
    expect(page).to have_css('.postgres_version', text: 'PostgreSQL 10.5')
  end
end
