require 'spec_helper'

RSpec.feature 'Fetching the status' do
  scenario 'returns a status message from the health endpoint' do
    start_page = ENV.fetch('START_PAGE') + '/health'

    visit start_page

    expect(page).to have_content('Everything is fine.')
  end
end
