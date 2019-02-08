# frozen_string_literal: true

require 'spec_helper'

RSpec.feature 'Allocation' do
  scenario 'create an allocation' do
    sign_in_and_go ENV.fetch('START_PAGE')
    click_link 'Awaiting allocation'

    within('.offender_row_0') do
      click_link 'Allocate'
    end

    within('.recommended_pom_row_0') do
      click_link 'Allocate'
    end

    click_button 'Complete allocation'

    expect(page).to have_css('.govuk-tabs__tab--selected', text: 'Allocated')
  end
end
