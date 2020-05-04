require 'capybara/rspec'
require 'spec_helper'

describe 'Select' do
  it 'Renders Select components' do
    visit 'http://components-select-app:3000'
    click_on 'Start'

    # select
    expect(page).to have_selector '.fb-sectionHeading', text: 'Select - First - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Select - First'
    expect(page).to have_selector '.govuk-hint', text: 'Select - First - hint text'

    select 'One', from: 'page_select-first--select_auto_name_1'
    continue

    # select
    expect(page).to have_selector '.fb-sectionHeading', text: 'Select - Second - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Select - Second'
    expect(page).to have_selector '.govuk-hint', text: 'Select - Second - hint text'

    select 'Two', from: 'page_select-second--select_auto_name_2'
    continue

    # select
    expect(page).to have_selector '.fb-sectionHeading', text: 'Select - Third - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Select - Third'
    expect(page).to have_selector '.govuk-hint', text: 'Select - Third - hint text'

    select 'Three', from: 'page_select-third--select_auto_name_3'
    continue

    # select
    expect(page).to have_selector '.fb-sectionHeading', text: 'Select - Fourth - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Select - Fourth'
    expect(page).to have_selector '.govuk-hint', text: 'Select - Fourth - hint text'

    select 'Four', from: 'page_select-fourth--select_auto_name_4'
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector '.fb-sectionHeading', text: 'Select - Summary - section heading'
    expect(page).to have_selector 'h1', text: 'Summary'

    expect(page).to have_selector 'h2:nth-of-type(1)', text: 'Select - First - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__key', text: 'Select - First'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__value', text: 'One'

    expect(page).to have_selector 'h2:nth-of-type(2)', text: 'Select - Second - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__key', text: 'Select - Second'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__value', text: 'Two'

    expect(page).to have_selector 'h2:nth-of-type(3)', text: 'Select - Third - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__key', text: 'Select - Third'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__value', text: 'Three - summary version'

    expect(page).to have_selector 'h2:nth-of-type(4)', text: 'Select - Fourth - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__key', text: 'Select - Fourth'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__value', text: 'Four - summary version'

    ########################################
    #                                      #
    #   CHANGE                             #
    #                                      #
    ########################################

    # change
    find('.govuk-summary-list:nth-of-type(4) .govuk-summary-list__actions a').click

    # select
    expect(page).to have_selector '.fb-sectionHeading', text: 'Select - Fourth - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Select - Fourth'
    expect(page).to have_selector '.govuk-hint', text: 'Select - Fourth - hint text'

    select 'One', from: 'page_select-fourth--select_auto_name_4'
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector 'h2:nth-of-type(4)', text: 'Select - Fourth - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__key', text: 'Select - Fourth'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__value', text: 'One - summary version'

    ########################################
    #                                      #
    #   BACK                               #
    #                                      #
    ########################################

    # back
    back

    # fourth
    expect(page).to have_selector '.fb-sectionHeading', text: 'Select - Fourth - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Select - Fourth'
    expect(page).to have_selector '.govuk-hint', text: 'Select - Fourth - hint text'

    expect(page).to have_select 'page_select-fourth--select_auto_name_4', selected: 'One'
    back

    # third
    expect(page).to have_selector '.fb-sectionHeading', text: 'Select - Third - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Select - Third'
    expect(page).to have_selector '.govuk-hint', text: 'Select - Third - hint text'

    expect(page).to have_select 'page_select-third--select_auto_name_3', selected: 'Three'
    back

    # second
    expect(page).to have_selector '.fb-sectionHeading', text: 'Select - Second - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Select - Second'
    expect(page).to have_selector '.govuk-hint', text: 'Select - Second - hint text'

    expect(page).to have_select 'page_select-second--select_auto_name_2', selected: 'Two'
    back

    # first
    expect(page).to have_selector '.fb-sectionHeading', text: 'Select - First - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Select - First'
    expect(page).to have_selector '.govuk-hint', text: 'Select - First - hint text'

    expect(page).to have_select 'page_select-first--select_auto_name_1', selected: 'One'
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
    expect(page).to have_selector '.fb-sectionHeading', text: 'Select - First - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Select - First'
    expect(page).to have_selector '.govuk-hint', text: 'Select - First - hint text'

    expect(page).to have_select 'page_select-first--select_auto_name_1', selected: 'One'
    continue

    # second
    expect(page).to have_selector '.fb-sectionHeading', text: 'Select - Second - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Select - Second'
    expect(page).to have_selector '.govuk-hint', text: 'Select - Second - hint text'

    expect(page).to have_select 'page_select-second--select_auto_name_2', selected: 'Two'
    continue

    # third
    expect(page).to have_selector '.fb-sectionHeading', text: 'Select - Third - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Select - Third'
    expect(page).to have_selector '.govuk-hint', text: 'Select - Third - hint text'

    expect(page).to have_select 'page_select-third--select_auto_name_3', selected: 'Three'
    continue

    # fourth
    expect(page).to have_selector '.fb-sectionHeading', text: 'Select - Fourth - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Select - Fourth'
    expect(page).to have_selector '.govuk-hint', text: 'Select - Fourth - hint text'

    expect(page).to have_select 'page_select-fourth--select_auto_name_4', selected: 'One'
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector '.fb-sectionHeading', text: 'Select - Summary - section heading'
    expect(page).to have_selector 'h1', text: 'Summary'

    expect(page).to have_selector 'h2:nth-of-type(1)', text: 'Select - First - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__key', text: 'Select - First'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__value', text: 'One'

    expect(page).to have_selector 'h2:nth-of-type(2)', text: 'Select - Second - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__key', text: 'Select - Second'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__value', text: 'Two'

    expect(page).to have_selector 'h2:nth-of-type(3)', text: 'Select - Third - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__key', text: 'Select - Third'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__value', text: 'Three - summary version'

    expect(page).to have_selector 'h2:nth-of-type(4)', text: 'Select - Fourth - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__key', text: 'Select - Fourth'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__value', text: 'One - summary version'

    click_on 'Accept and send application'

    # confirmation
    expect(page).to have_selector 'h1.govuk-panel__title', text: 'Select - Confirmation'
  end

  def back
    find('.govuk-back-link').click
  end

  def continue
    click_on 'Continue'
  end
end
