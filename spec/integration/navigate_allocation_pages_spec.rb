require 'spec_helper'

RSpec.feature 'Allocation pagination' do
  scenario 'pages through each page in allocations' do
    sign_in_and_go ENV.fetch('START_PAGE')
    expect(page).to have_content('Dashboard')

    click_on('Allocated prisoners')

    for p in 2..6 do
      s = ((p - 2) * 10) + 1
      expect(page).to have_content("#{s} - #{s+9}")
      click_link( p.to_s, wait: 10 )
      expect(page).to have_selector("a", text: '« Previous')
    end
  end

  scenario 'pages through each page in waiting allocations' do
    sign_in_and_go ENV.fetch('START_PAGE')
    expect(page).to have_content('Dashboard')

    click_on('Awaiting allocation')

    for p in 2..6 do
      s = ((p - 2) * 10) + 1
      expect(page).to have_content("#{s} - #{s+9}")
      click_link( p.to_s, wait: 10 )
      expect(page).to have_selector("a", text: '« Previous')
    end
  end

  scenario 'pages through each page in missing information' do
    sign_in_and_go ENV.fetch('START_PAGE')
    expect(page).to have_content('Dashboard')

    click_on('Missing information')

    for p in 2..6 do
      s = ((p - 2) * 10) + 1
      expect(page).to have_content("#{s} - #{s+9}")
      click_link( p.to_s, wait: 10 )
      expect(page).to have_selector("a", text: '« Previous')
    end
  end

  scenario 'pages through each page in allocations with next/previous link' do
    sign_in_and_go ENV.fetch('START_PAGE')
    expect(page).to have_content('Dashboard')

    click_on('Allocated prisoners')

    click_link( 'Next »', wait: 10 )
    expect(page).to have_selector("a", text: '« Previous')

    click_link( '« Previous', wait: 10 )
    expect(page).to_not have_selector("a", text: '« Previous')
  end

  scenario 'pages through each page in waiting allocations with next/previous link' do
    sign_in_and_go ENV.fetch('START_PAGE')
    expect(page).to have_content('Dashboard')

    click_on('Awaiting allocation')

    click_link( 'Next »', wait: 10 )
    expect(page).to have_selector("a", text: '« Previous')

    click_link( '« Previous', wait: 10 )
    expect(page).to_not have_selector("a", text: '« Previous')
  end

  scenario 'pages through each page in missing information with next/previous link' do
    sign_in_and_go ENV.fetch('START_PAGE')
    expect(page).to have_content('Dashboard')

    click_on('Missing information')

    click_link( 'Next »', wait: 10 )
    expect(page).to have_selector("a", text: '« Previous')

    click_link( '« Previous', wait: 10 )
    expect(page).to_not have_selector("a", text: '« Previous')
  end
end
