require 'capybara/rspec'
require 'spec_helper'

describe 'Number' do
  it 'Renders Number components' do
    visit 'http://components-number-app:3000'
    click_on 'Start'

    # number
    expect(page).to have_selector '.fb-sectionHeading', text: 'Number - First - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Number - First'
    expect(page).to have_selector '.govuk-hint', text: 'Number - First - hint text'

    fill_in 'page_number-first--number_auto_name_1', with: "1"
    continue

    # number
    expect(page).to have_selector '.fb-sectionHeading', text: 'Number - Second - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Number - Second'
    expect(page).to have_selector '.govuk-hint', text: 'Number - Second - hint text'

    fill_in 'page_number-second--number_auto_name_2', with: "2"
    continue

    # number
    expect(page).to have_selector '.fb-sectionHeading', text: 'Number - Third - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Number - Third'
    expect(page).to have_selector '.govuk-hint', text: 'Number - Third - hint text'

    fill_in 'number-third', with: "3"
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector '.fb-sectionHeading', text: 'Number - Summary - section heading'
    expect(page).to have_selector 'h1', text: 'Summary'

    expect(page).to have_selector 'h2:nth-of-type(1)', text: 'Number - First - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__key', text: 'Number - First'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__value', text: '1'

    expect(page).to have_selector 'h2:nth-of-type(2)', text: 'Number - Second - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__key', text: 'Number - Second'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__value', text: '2'

    expect(page).to have_selector 'h2:nth-of-type(3)', text: 'Number - Third - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__key', text: 'Number - Third'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__value', text: '3'

    ########################################
    #                                      #
    #   CHANGE                             #
    #                                      #
    ########################################

    # change
    find('.govuk-summary-list:nth-of-type(3) .govuk-summary-list__actions a').click

    # number
    expect(page).to have_selector '.fb-sectionHeading', text: 'Number - Third - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Number - Third'
    expect(page).to have_selector '.govuk-hint', text: 'Number - Third - hint text'

    fill_in 'number-third', with: "1"
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector 'h2:nth-of-type(3)', text: 'Number - Third - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__key', text: 'Number - Third'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__value', text: '1'

    ########################################
    #                                      #
    #   BACK                               #
    #                                      #
    ########################################

    # back
    back

    # third
    expect(page).to have_selector '.fb-sectionHeading', text: 'Number - Third - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Number - Third'
    expect(page).to have_selector '.govuk-hint', text: 'Number - Third - hint text'

    expect(find_field('number-third').value).to eq '1'
    back

    # second
    expect(page).to have_selector '.fb-sectionHeading', text: 'Number - Second - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Number - Second'
    expect(page).to have_selector '.govuk-hint', text: 'Number - Second - hint text'

    expect(find_field('page_number-second--number_auto_name_2').value).to eq '2'
    back

    # first
    expect(page).to have_selector '.fb-sectionHeading', text: 'Number - First - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Number - First'
    expect(page).to have_selector '.govuk-hint', text: 'Number - First - hint text'

    expect(find_field('page_number-first--number_auto_name_1').value).to eq '1'
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
    expect(page).to have_selector '.fb-sectionHeading', text: 'Number - First - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Number - First'
    expect(page).to have_selector '.govuk-hint', text: 'Number - First - hint text'

    expect(find_field('page_number-first--number_auto_name_1').value).to eq '1'
    continue

    # second
    expect(page).to have_selector '.fb-sectionHeading', text: 'Number - Second - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Number - Second'
    expect(page).to have_selector '.govuk-hint', text: 'Number - Second - hint text'

    expect(find_field('page_number-second--number_auto_name_2').value).to eq '2'
    continue

    # third
    expect(page).to have_selector '.fb-sectionHeading', text: 'Number - Third - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Number - Third'
    expect(page).to have_selector '.govuk-hint', text: 'Number - Third - hint text'

    expect(find_field('number-third').value).to eq '1'
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector '.fb-sectionHeading', text: 'Number - Summary - section heading'
    expect(page).to have_selector 'h1', text: 'Summary'

    expect(page).to have_selector 'h2:nth-of-type(1)', text: 'Number - First - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__key', text: 'Number - First'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__value', text: '1'

    expect(page).to have_selector 'h2:nth-of-type(2)', text: 'Number - Second - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__key', text: 'Number - Second'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__value', text: '2'

    expect(page).to have_selector 'h2:nth-of-type(3)', text: 'Number - Third - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__key', text: 'Number - Third'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__value', text: '1'

    click_on 'Accept and send application'

    # confirmation
    expect(page).to have_selector 'h1.govuk-panel__title', text: 'Number - Confirmation'
  end

  def back
    find('.govuk-back-link').click
  end

  def continue
    click_on 'Continue'
  end
end
