# frozen_string_literal: true

require 'spec_helper'

RSpec.feature 'Allocation' do
  scenario 'create an allocation' do
    sign_in_and_go ENV.fetch('START_PAGE')
    click_link 'Awaiting information'

    within('.offender_row_0') do
      click_link 'Edit'
    end

    tiers = %w[a b c d]

    fill_in_case_information(tiers.sample)

    click_button 'Save'

    sleep 5

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

  def fill_in_case_information(tier)
    case tier
    when 'a'
      select_case_allocation('NPS')
      select_tier('A')
    when 'b'
      select_case_allocation('NPS')
      select_tier('B')
    when 'c'
      select_case_allocation('CRC')
      select_tier('C')
    when 'd'
      select_case_allocation('CRC')
      select_tier('D')
    end
  end

  def select_case_allocation(case_allocation)
    find("#case_information_case_allocation_#{case_allocation}", visible: false).choose
  end

  def select_tier(tier)
    find("#case_information_tier_#{tier}", visible: false).choose
  end
end
