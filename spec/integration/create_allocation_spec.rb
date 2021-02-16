# frozen_string_literal: true

require 'spec_helper'

RSpec.feature 'Allocation' do
  scenario 'create an allocation' do
    sign_in_and_go_staging ENV.fetch('STAGING_START_PAGE')

    click_link 'Update case information'

    within('.offender_row_0') do
      click_link 'Edit'
    end

    find("#case_information_welsh_offender_Yes", visible: false).choose

    tiers = %w[a b c d]
    fill_in_case_information(tiers.sample)

    click_button 'Save'
    expect(page).to have_content('Add missing information')

    click_link 'Make allocations'
    expect(page).to have_content('Make allocations')

    within('.offender_row_0') do
      click_link 'Allocate'
    end

    pom_rows = %w[0 1 2]

    within(".recommended_pom_row_#{pom_rows.sample}") do
      click_link 'Allocate'
    end

    click_button 'Complete allocation'

    # Explicitly wait for the following page to load, it's a slow one so we can't
    # assume the page URL has already changed.
    sleep 30
    expect(page).to have_content('Make allocations')
  end

  def fill_in_case_information(tier)
    case tier
    when 'a'
      select_case_allocation('NPS')
      select_tier('A')
      select_welshness('Yes')
    when 'b'
      select_case_allocation('NPS')
      select_tier('B')
      select_welshness('Yes')
    when 'c'
      select_case_allocation('CRC')
      select_tier('C')
      select_welshness('Yes')
    when 'd'
      select_case_allocation('CRC')
      select_tier('D')
      select_welshness('Yes')
    end
  end

  def select_welshness(val)
    find("#case_information_welsh_offender_#{val}", visible: false).choose
  end

  def select_case_allocation(case_allocation)
    find("#case_information_case_allocation_#{case_allocation}", visible: false).choose
  end

  def select_tier(tier)
    find("#case_information_tier_#{tier}", visible: false).choose
  end
end
