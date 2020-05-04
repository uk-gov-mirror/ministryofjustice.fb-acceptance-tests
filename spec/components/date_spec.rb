require 'capybara/rspec'
require 'spec_helper'

describe 'Date' do
  it 'Renders Date components' do
    visit 'http://components-date-app:3000'
    click_on 'Start'

    # date
    expect(page).to have_selector '.fb-sectionHeading', text: 'Date - First - section heading'
    expect(page).to have_selector 'h1', text: 'Date - First'
    expect(page).to have_selector '.govuk-hint', text: 'Date - First - hint text'

    fill_in 'COMPOSITE--auto_name_1-day', with: "1"
    fill_in 'COMPOSITE--auto_name_1-month', with: "1"
    fill_in 'COMPOSITE--auto_name_1-year', with: "1970"

    continue

    # date
    expect(page).to have_selector '.fb-sectionHeading', text: 'Date - Second - section heading'
    expect(page).to have_selector 'h1', text: 'Date - Second'
    expect(page).to have_selector '.govuk-hint', text: 'Date - Second - hint text'

    fill_in 'COMPOSITE--auto_name_2-day', with: "2"
    fill_in 'COMPOSITE--auto_name_2-month', with: "2"
    fill_in 'COMPOSITE--auto_name_2-year', with: "1971"
    continue

    # date
    expect(page).to have_selector '.fb-sectionHeading', text: 'Date - Third - section heading'
    expect(page).to have_selector 'h1', text: 'Date - Third'
    expect(page).to have_selector '.govuk-hint', text: 'Date - Third - hint text'

    fill_in 'COMPOSITE--auto_name_3-day', with: "3"
    fill_in 'COMPOSITE--auto_name_3-month', with: "3"
    fill_in 'COMPOSITE--auto_name_3-year', with: "1972"
    continue

    # date
    expect(page).to have_selector '.fb-sectionHeading', text: 'Date - Fourth - section heading'
    expect(page).to have_selector 'h1', text: 'Date - Fourth'
    expect(page).to have_selector '.govuk-hint', text: 'Date - Fourth - hint text'

    fill_in 'COMPOSITE--date-fourth-day', with: "4"
    fill_in 'COMPOSITE--date-fourth-month', with: "4"
    fill_in 'COMPOSITE--date-fourth-year', with: "1973"
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector '.fb-sectionHeading', text: 'Date - Summary - section heading'
    expect(page).to have_selector 'h1', text: 'Summary'

    expect(page).to have_selector 'h2:nth-of-type(1)', text: 'Date - First - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__key', text: 'Date - First'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__value', text: '1 January 1970'

    expect(page).to have_selector 'h2:nth-of-type(2)', text: 'Date - Second - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__key', text: 'Date - Second'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__value', text: '2 February 1971'

    expect(page).to have_selector 'h2:nth-of-type(3)', text: 'Date - Third - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__key', text: 'Date - Third'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__value', text: '3 March 1972'

    expect(page).to have_selector 'h2:nth-of-type(4)', text: 'Date - Fourth - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__key', text: 'Date - Fourth'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__value', text: '4 April 1973'

    ########################################
    #                                      #
    #   CHANGE                             #
    #                                      #
    ########################################

    # change
    find('.govuk-summary-list:nth-of-type(4) .govuk-summary-list__actions a').click

    # date
    expect(page).to have_selector '.fb-sectionHeading', text: 'Date - Fourth - section heading'
    expect(page).to have_selector 'h1', text: 'Date - Fourth'
    expect(page).to have_selector '.govuk-hint', text: 'Date - Fourth - hint text'

    fill_in 'COMPOSITE--date-fourth-day', with: "1"
    fill_in 'COMPOSITE--date-fourth-month', with: "1"
    fill_in 'COMPOSITE--date-fourth-year', with: "1970"
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector 'h2:nth-of-type(4)', text: 'Date - Fourth - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__key', text: 'Date - Fourth'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__value', text: '1 January 1970'

    ########################################
    #                                      #
    #   BACK                               #
    #                                      #
    ########################################

    # back
    back

    # fourth
    expect(page).to have_selector '.fb-sectionHeading', text: 'Date - Fourth - section heading'
    expect(page).to have_selector 'h1', text: 'Date - Fourth'
    expect(page).to have_selector '.govuk-hint', text: 'Date - Fourth - hint text'

    expect(find_field('COMPOSITE--date-fourth-day').value).to eq '1'
    expect(find_field('COMPOSITE--date-fourth-month').value).to eq '1'
    expect(find_field('COMPOSITE--date-fourth-year').value).to eq '1970'
    back

    # third
    expect(page).to have_selector '.fb-sectionHeading', text: 'Date - Third - section heading'
    expect(page).to have_selector 'h1', text: 'Date - Third'
    expect(page).to have_selector '.govuk-hint', text: 'Date - Third - hint text'

    expect(find_field('COMPOSITE--auto_name_3-day').value).to eq '3'
    expect(find_field('COMPOSITE--auto_name_3-month').value).to eq '3'
    expect(find_field('COMPOSITE--auto_name_3-year').value).to eq '1972'
    back

    # second
    expect(page).to have_selector '.fb-sectionHeading', text: 'Date - Second - section heading'
    expect(page).to have_selector 'h1', text: 'Date - Second'
    expect(page).to have_selector '.govuk-hint', text: 'Date - Second - hint text'

    expect(find_field('COMPOSITE--auto_name_2-day').value).to eq '2'
    expect(find_field('COMPOSITE--auto_name_2-month').value).to eq '2'
    expect(find_field('COMPOSITE--auto_name_2-year').value).to eq '1971'
    back

    # first
    expect(page).to have_selector '.fb-sectionHeading', text: 'Date - First - section heading'
    expect(page).to have_selector 'h1', text: 'Date - First'
    expect(page).to have_selector '.govuk-hint', text: 'Date - First - hint text'

    expect(find_field('COMPOSITE--auto_name_1-day').value).to eq '1'
    expect(find_field('COMPOSITE--auto_name_1-month').value).to eq '1'
    expect(find_field('COMPOSITE--auto_name_1-year').value).to eq '1970'
    back

    ########################################
    #                                      #
    #   START                              #
    #                                      #
    ########################################

    # start
    click_on 'Start'

    ########################################
    #                                      #
    #   FORWARD                            #
    #                                      #
    ########################################

    # first
    expect(page).to have_selector '.fb-sectionHeading', text: 'Date - First - section heading'
    expect(page).to have_selector 'h1', text: 'Date - First'
    expect(page).to have_selector '.govuk-hint', text: 'Date - First - hint text'

    expect(find_field('COMPOSITE--auto_name_1-day').value).to eq '1'
    expect(find_field('COMPOSITE--auto_name_1-month').value).to eq '1'
    expect(find_field('COMPOSITE--auto_name_1-year').value).to eq '1970'
    continue

    # second
    expect(page).to have_selector '.fb-sectionHeading', text: 'Date - Second - section heading'
    expect(page).to have_selector 'h1', text: 'Date - Second'
    expect(page).to have_selector '.govuk-hint', text: 'Date - Second - hint text'

    expect(find_field('COMPOSITE--auto_name_2-day').value).to eq '2'
    expect(find_field('COMPOSITE--auto_name_2-month').value).to eq '2'
    expect(find_field('COMPOSITE--auto_name_2-year').value).to eq '1971'
    continue

    # third
    expect(page).to have_selector '.fb-sectionHeading', text: 'Date - Third - section heading'
    expect(page).to have_selector 'h1', text: 'Date - Third'
    expect(page).to have_selector '.govuk-hint', text: 'Date - Third - hint text'

    expect(find_field('COMPOSITE--auto_name_3-day').value).to eq '3'
    expect(find_field('COMPOSITE--auto_name_3-month').value).to eq '3'
    expect(find_field('COMPOSITE--auto_name_3-year').value).to eq '1972'
    continue

    # fourth
    expect(page).to have_selector '.fb-sectionHeading', text: 'Date - Fourth - section heading'
    expect(page).to have_selector 'h1', text: 'Date - Fourth'
    expect(page).to have_selector '.govuk-hint', text: 'Date - Fourth - hint text'

    expect(find_field('COMPOSITE--date-fourth-day').value).to eq '1'
    expect(find_field('COMPOSITE--date-fourth-month').value).to eq '1'
    expect(find_field('COMPOSITE--date-fourth-year').value).to eq '1970'
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector '.fb-sectionHeading', text: 'Date - Summary - section heading'
    expect(page).to have_selector 'h1', text: 'Summary'

    expect(page).to have_selector 'h2:nth-of-type(1)', text: 'Date - First - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__key', text: 'Date - First'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__value', text: '1 January 1970'

    expect(page).to have_selector 'h2:nth-of-type(2)', text: 'Date - Second - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__key', text: 'Date - Second'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__value', text: '2 February 1971'

    expect(page).to have_selector 'h2:nth-of-type(3)', text: 'Date - Third - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__key', text: 'Date - Third'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__value', text: '3 March 1972'

    expect(page).to have_selector 'h2:nth-of-type(4)', text: 'Date - Fourth - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__key', text: 'Date - Fourth'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__value', text: '1 January 1970'

    click_on 'Accept and send application'

    # confirmation
    expect(page).to have_selector 'h1.govuk-panel__title', text: 'Date - Confirmation'
  end

  def back
    find('.govuk-back-link').click
  end

  def continue
    click_on 'Continue'
  end
end
