# frozen_string_literal: true

require 'spec_helper'

RSpec.feature 'Allocation' do
  scenario 'create an allocation' do
    sign_in_and_go_staging ENV.fetch('STAGING_START_PAGE')

    expect(page).to have_heading('Dashboard')
    click_link 'Add missing details'

    expect(page).to have_heading('Add missing details')

    within('.offender_row_0') do
      click_link 'Add missing details'
    end

    select_welshness('Yes')

    tiers = %w[a b c d]
    fill_in_case_information(tiers.sample)

    click_button 'Save'
    expect(page).to have_heading('Add missing details')

    click_link 'Make new allocations'
    expect(page).to have_heading('Make new allocations')

    within('.offender_row_0') do
      within('td[aria-label="Prisoner name"]') do
        find('a').click
      end
    end

    expect(page).to have_heading('Allocate a POM')

    pom_rows = %w[1 2 3]

    within '#recommended_poms' do
      within "tbody > tr:nth-child(#{pom_rows.sample})" do
        click_link 'Allocate'
      end
    end

    click_button 'Complete allocation'

    # Explicitly wait for the following page to load, it's a slow one so we can't
    # assume the page URL has already changed.
    wait_for { current_path.include?('unallocated') }

    expect(page).to have_heading('Make new allocations')

    within('.notification') do
      # Expect to see flash message "{Offender Name} has been allocated to {POM name}"
      expect(page).to have_content 'has been allocated'
    end
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
    if val == 'Yes'
      find('label[for=case-information-probation-service-wales-field]').click
    else
      find('label[for=case-information-probation-service-england-field]').click
    end
  end

  def select_case_allocation(case_allocation)
    find("label[for=case-information-case-allocation-#{case_allocation.downcase}-field]").click
  end

  def select_tier(tier)
    find("label[for=case-information-tier-#{tier.downcase}-field]").click
  end
end
