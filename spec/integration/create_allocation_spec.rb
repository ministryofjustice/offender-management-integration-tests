# frozen_string_literal: true

require 'spec_helper'

RSpec.feature 'Allocation' do
  scenario 'create an allocation' do
    sign_in_and_go ENV.fetch('START_PAGE')
    click_link 'Awaiting information'

    within('.offender_row_0') do
      click_link 'Edit'
    end

    find('#case_information_case_allocation_NPS', visible: false).choose
    find('#case_information_tier_A', visible: false).choose
    click_button 'Save'

    visit "#{ENV.fetch('START_PAGE')}/summary#awaiting-allocation"
    within('.offender_row_0') do
      click_link 'Allocate'
    end

    within('.recommended_pom_row_0') do
      click_link 'Allocate'
    end

    click_button 'Complete allocation'

    expect(page).to have_current_path "#{ENV.fetch('START_PAGE')}/summary#awaiting-allocation"
  end
end
