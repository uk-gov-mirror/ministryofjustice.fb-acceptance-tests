require 'capybara/rspec'
require 'spec_helper'

describe 'Autocomplete' do
  it 'Renders Autocomplete components' do
    visit 'http://components-autocomplete-app:3000'
    click_on 'Start'

    # autocomplete
    expect(page).to have_selector '.fb-sectionHeading', text: 'Autocomplete - First - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Autocomplete - First'
    expect(page).to have_selector '.govuk-hint', text: 'Autocomplete - First - hint text'

    fill_in 'page_autocomplete-first--autocomplete_auto_name_1', with: "One\n" # the new line "presses enter" on the selected option
    continue

    # autocomplete
    expect(page).to have_selector '.fb-sectionHeading', text: 'Autocomplete - Second - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Autocomplete - Second'
    expect(page).to have_selector '.govuk-hint', text: 'Autocomplete - Second - hint text'

    fill_in 'page_autocomplete-second--autocomplete_auto_name_2', with: "Two\n" # the new line "presses enter" on the selected option
    continue

    # autocomplete
    expect(page).to have_selector '.fb-sectionHeading', text: 'Autocomplete - Third - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Autocomplete - Third'
    expect(page).to have_selector '.govuk-hint', text: 'Autocomplete - Third - hint text'

    fill_in 'page_autocomplete-third--autocomplete_auto_name_3', with: "Three\n" # the new line "presses enter" on the selected option
    continue

    # autocomplete
    expect(page).to have_selector '.fb-sectionHeading', text: 'Autocomplete - Fourth - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Autocomplete - Fourth'
    expect(page).to have_selector '.govuk-hint', text: 'Autocomplete - Fourth - hint text'

    fill_in 'page_autocomplete-fourth--autocomplete_auto_name_4', with: "Four\n" # the new line "presses enter" on the selected option
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector '.fb-sectionHeading', text: 'Autocomplete - Summary - section heading'
    expect(page).to have_selector 'h1', text: 'Summary'

    expect(page).to have_selector 'h2:nth-of-type(1)', text: 'Autocomplete - First - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__key', text: 'Autocomplete - First'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__value', text: 'One'

    expect(page).to have_selector 'h2:nth-of-type(2)', text: 'Autocomplete - Second - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__key', text: 'Autocomplete - Second'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__value', text: 'Two'

    expect(page).to have_selector 'h2:nth-of-type(3)', text: 'Autocomplete - Third - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__key', text: 'Autocomplete - Third'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__value', text: 'Three - summary version'

    expect(page).to have_selector 'h2:nth-of-type(4)', text: 'Autocomplete - Fourth - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__key', text: 'Autocomplete - Fourth'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__value', text: 'Four - summary version'

    ########################################
    #                                      #
    #   CHANGE                             #
    #                                      #
    ########################################

    # change
    find('.govuk-summary-list:nth-of-type(4) .govuk-summary-list__actions a').click

    # autocomplete
    expect(page).to have_selector '.fb-sectionHeading', text: 'Autocomplete - Fourth - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Autocomplete - Fourth'
    expect(page).to have_selector '.govuk-hint', text: 'Autocomplete - Fourth - hint text'

    fill_in 'page_autocomplete-fourth--autocomplete_auto_name_4', with: "One\n" # the new line 'presses enter' on the selected option
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector 'h2:nth-of-type(4)', text: 'Autocomplete - Fourth - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__key', text: 'Autocomplete - Fourth'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__value', text: 'One - summary version'

    ########################################
    #                                      #
    #   BACK                               #
    #                                      #
    ########################################

    # back
    back

    # fourth
    expect(page).to have_selector '.fb-sectionHeading', text: 'Autocomplete - Fourth - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Autocomplete - Fourth'
    expect(page).to have_selector '.govuk-hint', text: 'Autocomplete - Fourth - hint text'

    expect(find_field('page_autocomplete-fourth--autocomplete_auto_name_4').value).to eq 'One'
    back

    # third
    expect(page).to have_selector '.fb-sectionHeading', text: 'Autocomplete - Third - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Autocomplete - Third'
    expect(page).to have_selector '.govuk-hint', text: 'Autocomplete - Third - hint text'

    expect(find_field('page_autocomplete-third--autocomplete_auto_name_3').value).to eq 'Three'
    back

    # second
    expect(page).to have_selector '.fb-sectionHeading', text: 'Autocomplete - Second - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Autocomplete - Second'
    expect(page).to have_selector '.govuk-hint', text: 'Autocomplete - Second - hint text'

    expect(find_field('page_autocomplete-second--autocomplete_auto_name_2').value).to eq 'Two'
    back

    # first
    expect(page).to have_selector '.fb-sectionHeading', text: 'Autocomplete - First - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Autocomplete - First'
    expect(page).to have_selector '.govuk-hint', text: 'Autocomplete - First - hint text'

    expect(find_field('page_autocomplete-first--autocomplete_auto_name_1').value).to eq 'One'
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
    expect(page).to have_selector '.fb-sectionHeading', text: 'Autocomplete - First - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Autocomplete - First'
    expect(page).to have_selector '.govuk-hint', text: 'Autocomplete - First - hint text'

    expect(find_field('page_autocomplete-first--autocomplete_auto_name_1').value).to eq 'One'
    continue

    # second
    expect(page).to have_selector '.fb-sectionHeading', text: 'Autocomplete - Second - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Autocomplete - Second'
    expect(page).to have_selector '.govuk-hint', text: 'Autocomplete - Second - hint text'

    expect(find_field('page_autocomplete-second--autocomplete_auto_name_2').value).to eq 'Two'
    continue

    # third
    expect(page).to have_selector '.fb-sectionHeading', text: 'Autocomplete - Third - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Autocomplete - Third'
    expect(page).to have_selector '.govuk-hint', text: 'Autocomplete - Third - hint text'

    expect(find_field('page_autocomplete-third--autocomplete_auto_name_3').value).to eq 'Three'
    continue

    # fourth
    expect(page).to have_selector '.fb-sectionHeading', text: 'Autocomplete - Fourth - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Autocomplete - Fourth'
    expect(page).to have_selector '.govuk-hint', text: 'Autocomplete - Fourth - hint text'

    expect(find_field('page_autocomplete-fourth--autocomplete_auto_name_4').value).to eq 'One'
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector '.fb-sectionHeading', text: 'Autocomplete - Summary - section heading'
    expect(page).to have_selector 'h1', text: 'Summary'

    click_on 'Accept and send application'

    # confirmation
    expect(page).to have_selector 'h1.govuk-panel__title', text: 'Autocomplete - Confirmation'
  end

  def back
    find('.govuk-back-link').click
  end

  def continue
    click_on 'Continue'
  end
end
