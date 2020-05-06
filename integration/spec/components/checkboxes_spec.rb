require 'capybara/rspec'
require 'spec_helper'

describe 'Checkboxes' do
  it 'Renders Checkboxes components' do
    visit 'http://components-checkboxes-app:3000'
    click_on 'Start'

    # checkboxes
    expect(page).to have_selector '.fb-sectionHeading', text: 'Checkboxes - First - section heading'
    expect(page).to have_selector 'h1', text: 'Checkboxes - First'
    expect(page).to have_selector '.govuk-hint', text: 'Checkboxes - First - hint text'

    check 'auto_name__1', visible: false
    continue

    # checkboxes
    expect(page).to have_selector '.fb-sectionHeading', text: 'Checkboxes - Second - section heading'
    expect(page).to have_selector 'h1', text: 'Checkboxes - Second'
    expect(page).to have_selector '.govuk-hint', text: 'Checkboxes - Second - hint text'

    check 'auto_name__6', visible: false
    continue

    # checkboxes
    expect(page).to have_selector '.fb-sectionHeading', text: 'Checkboxes - Third - section heading'
    expect(page).to have_selector 'h1', text: 'Checkboxes - Third'
    expect(page).to have_selector '.govuk-hint', text: 'Checkboxes - Third - hint text'

    check 'auto_name__11', visible: false
    continue

    # checkboxes
    expect(page).to have_selector '.fb-sectionHeading', text: 'Checkboxes - Fourth - section heading'
    expect(page).to have_selector 'h1', text: 'Checkboxes - Fourth'
    expect(page).to have_selector '.govuk-hint', text: 'Checkboxes - Fourth - hint text'

    check 'checkboxes-one', visible: false
    check 'checkboxes-two', visible: false
    check 'checkboxes-three', visible: false
    check 'checkboxes-four', visible: false
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector '.fb-sectionHeading', text: 'Checkboxes - Summary - section heading'
    expect(page).to have_selector 'h1', text: 'Summary'

    expect(page).to have_selector 'h2:nth-of-type(1)', text: 'Checkboxes - First - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__key', text: 'Checkboxes - First'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__value', text: 'One'

    expect(page).to have_selector 'h2:nth-of-type(2)', text: 'Checkboxes - Second - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__key', text: 'Checkboxes - Second'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__value', text: 'Two'

    expect(page).to have_selector 'h2:nth-of-type(3)', text: 'Checkboxes - Third - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__key', text: 'Checkboxes - Third'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__value', text: 'Three - summary version'

    expect(page).to have_selector 'h2:nth-of-type(4)', text: 'Checkboxes - Fourth - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__key', text: 'Checkboxes - Fourth'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__value', text: /One - summary version\s*Two - summary version\s*Three - summary version\s*Four - summary version/

    ########################################
    #                                      #
    #   CHANGE                             #
    #                                      #
    ########################################

    # change
    find('.govuk-summary-list:nth-of-type(4) .govuk-summary-list__actions a').click

    # checkboxes
    expect(page).to have_selector '.fb-sectionHeading', text: 'Checkboxes - Fourth - section heading'
    expect(page).to have_selector 'h1', text: 'Checkboxes - Fourth'
    expect(page).to have_selector '.govuk-hint', text: 'Checkboxes - Fourth - hint text'

    uncheck 'checkboxes-one', visible: false
    uncheck 'checkboxes-two', visible: false
    uncheck 'checkboxes-three', visible: false
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector 'h2:nth-of-type(4)', text: 'Checkboxes - Fourth - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__key', text: 'Checkboxes - Fourth'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__value', text: 'Four - summary version'

    ########################################
    #                                      #
    #   BACK                               #
    #                                      #
    ########################################

    # back
    back

    # fourth
    expect(page).to have_selector '.fb-sectionHeading', text: 'Checkboxes - Fourth - section heading'
    expect(page).to have_selector 'h1', text: 'Checkboxes - Fourth'
    expect(page).to have_selector '.govuk-hint', text: 'Checkboxes - Fourth - hint text'

    expect(page).to have_field('checkboxes-one', visible: false, checked: false)
    expect(page).to have_field('checkboxes-two', visible: false, checked: false)
    expect(page).to have_field('checkboxes-three', visible: false, checked: false)
    expect(page).to have_field('checkboxes-four', visible: false, checked: true)
    back

    # third
    expect(page).to have_selector '.fb-sectionHeading', text: 'Checkboxes - Third - section heading'
    expect(page).to have_selector 'h1', text: 'Checkboxes - Third'
    expect(page).to have_selector '.govuk-hint', text: 'Checkboxes - Third - hint text'

    expect(page).to have_field('auto_name__9', visible: false, checked: false)
    expect(page).to have_field('auto_name__10', visible: false, checked: false)
    expect(page).to have_field('auto_name__11', visible: false, checked: true)
    expect(page).to have_field('auto_name__12', visible: false, checked: false)
    back

    # second
    expect(page).to have_selector '.fb-sectionHeading', text: 'Checkboxes - Second - section heading'
    expect(page).to have_selector 'h1', text: 'Checkboxes - Second'
    expect(page).to have_selector '.govuk-hint', text: 'Checkboxes - Second - hint text'

    expect(page).to have_field('auto_name__5', visible: false, checked: false)
    expect(page).to have_field('auto_name__6', visible: false, checked: true)
    expect(page).to have_field('auto_name__7', visible: false, checked: false)
    expect(page).to have_field('auto_name__8', visible: false, checked: false)
    back

    # first
    expect(page).to have_selector '.fb-sectionHeading', text: 'Checkboxes - First - section heading'
    expect(page).to have_selector 'h1', text: 'Checkboxes - First'
    expect(page).to have_selector '.govuk-hint', text: 'Checkboxes - First - hint text'

    expect(page).to have_field('auto_name__1', visible: false, checked: true)
    expect(page).to have_field('auto_name__2', visible: false, checked: false)
    expect(page).to have_field('auto_name__3', visible: false, checked: false)
    expect(page).to have_field('auto_name__4', visible: false, checked: false)
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
    expect(page).to have_selector '.fb-sectionHeading', text: 'Checkboxes - First - section heading'
    expect(page).to have_selector 'h1', text: 'Checkboxes - First'
    expect(page).to have_selector '.govuk-hint', text: 'Checkboxes - First - hint text'

    expect(page).to have_field('auto_name__1', visible: false, checked: true)
    expect(page).to have_field('auto_name__2', visible: false, checked: false)
    expect(page).to have_field('auto_name__3', visible: false, checked: false)
    expect(page).to have_field('auto_name__4', visible: false, checked: false)
    continue

    # second
    expect(page).to have_selector '.fb-sectionHeading', text: 'Checkboxes - Second - section heading'
    expect(page).to have_selector 'h1', text: 'Checkboxes - Second'
    expect(page).to have_selector '.govuk-hint', text: 'Checkboxes - Second - hint text'

    expect(page).to have_field('auto_name__5', visible: false, checked: false)
    expect(page).to have_field('auto_name__6', visible: false, checked: true)
    expect(page).to have_field('auto_name__7', visible: false, checked: false)
    expect(page).to have_field('auto_name__8', visible: false, checked: false)
    continue

    # third
    expect(page).to have_selector '.fb-sectionHeading', text: 'Checkboxes - Third - section heading'
    expect(page).to have_selector 'h1', text: 'Checkboxes - Third'
    expect(page).to have_selector '.govuk-hint', text: 'Checkboxes - Third - hint text'

    expect(page).to have_field('auto_name__9', visible: false, checked: false)
    expect(page).to have_field('auto_name__10', visible: false, checked: false)
    expect(page).to have_field('auto_name__11', visible: false, checked: true)
    expect(page).to have_field('auto_name__12', visible: false, checked: false)
    continue

    # fourth
    expect(page).to have_selector '.fb-sectionHeading', text: 'Checkboxes - Fourth - section heading'
    expect(page).to have_selector 'h1', text: 'Checkboxes - Fourth'
    expect(page).to have_selector '.govuk-hint', text: 'Checkboxes - Fourth - hint text'

    expect(page).to have_field('checkboxes-one', visible: false, checked: false)
    expect(page).to have_field('checkboxes-two', visible: false, checked: false)
    expect(page).to have_field('checkboxes-three', visible: false, checked: false)
    expect(page).to have_field('checkboxes-four', visible: false, checked: true)
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector '.fb-sectionHeading', text: 'Checkboxes - Summary - section heading'
    expect(page).to have_selector 'h1', text: 'Summary'

    expect(page).to have_selector 'h2:nth-of-type(1)', text: 'Checkboxes - First - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__key', text: 'Checkboxes - First'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__value', text: 'One'

    expect(page).to have_selector 'h2:nth-of-type(2)', text: 'Checkboxes - Second - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__key', text: 'Checkboxes - Second'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__value', text: 'Two'

    expect(page).to have_selector 'h2:nth-of-type(3)', text: 'Checkboxes - Third - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__key', text: 'Checkboxes - Third'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__value', text: 'Three - summary version'

    expect(page).to have_selector 'h2:nth-of-type(4)', text: 'Checkboxes - Fourth - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__key', text: 'Checkboxes - Fourth'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__value', text: 'Four - summary version'

    click_on 'Accept and send application'

    # confirmation
    expect(page).to have_selector 'h1.govuk-panel__title', text: 'Checkboxes - Confirmation'
  end

  def back
    find('.govuk-back-link').click
  end

  def continue
    click_on 'Continue'
  end
end
