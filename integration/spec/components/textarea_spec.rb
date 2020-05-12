require 'capybara/rspec'
require 'spec_helper'

describe 'Textarea' do
  let(:form) { ComponentsTextareaApp.new }

  before { form.load }

  it 'Renders Textarea components' do
    click_on 'Start'

    # textarea
    expect(page).to have_selector '.fb-sectionHeading', text: 'Textarea - First - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Textarea - First'
    expect(page).to have_selector '.govuk-hint', text: 'Textarea - First - hint text'

    fill_in 'page_textarea-first--textarea_auto_name_1', with: "One"
    continue

    # textarea
    expect(page).to have_selector '.fb-sectionHeading', text: 'Textarea - Second - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Textarea - Second'
    expect(page).to have_selector '.govuk-hint', text: 'Textarea - Second - hint text'

    fill_in 'page_textarea-second--textarea_auto_name_2', with: "Two"
    continue

    # textarea
    expect(page).to have_selector '.fb-sectionHeading', text: 'Textarea - Third - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Textarea - Third'
    expect(page).to have_selector '.govuk-hint', text: 'Textarea - Third - hint text'

    fill_in 'textarea-third', with: "Three"
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector '.fb-sectionHeading', text: 'Textarea - Summary - section heading'
    expect(page).to have_selector 'h1', text: 'Summary'

    expect(page).to have_selector 'h2:nth-of-type(1)', text: 'Textarea - First - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__key', text: 'Textarea - First'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__value', text: 'One'

    expect(page).to have_selector 'h2:nth-of-type(2)', text: 'Textarea - Second - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__key', text: 'Textarea - Second'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__value', text: 'Two'

    expect(page).to have_selector 'h2:nth-of-type(3)', text: 'Textarea - Third - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__key', text: 'Textarea - Third'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__value', text: 'Three'

    ########################################
    #                                      #
    #   CHANGE                             #
    #                                      #
    ########################################

    # change
    find('.govuk-summary-list:nth-of-type(3) .govuk-summary-list__actions a').click

    # textarea
    expect(page).to have_selector '.fb-sectionHeading', text: 'Textarea - Third - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Textarea - Third'
    expect(page).to have_selector '.govuk-hint', text: 'Textarea - Third - hint text'

    fill_in 'textarea-third', with: "One"
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector 'h2:nth-of-type(3)', text: 'Textarea - Third - section heading'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__key', text: 'Textarea - Third'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__value', text: 'One'

    ########################################
    #                                      #
    #   BACK                               #
    #                                      #
    ########################################

    # back
    back

    # third
    expect(page).to have_selector '.fb-sectionHeading', text: 'Textarea - Third - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Textarea - Third'
    expect(page).to have_selector '.govuk-hint', text: 'Textarea - Third - hint text'

    expect(find_field('textarea-third').value).to eq 'One'
    back

    # second
    expect(page).to have_selector '.fb-sectionHeading', text: 'Textarea - Second - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Textarea - Second'
    expect(page).to have_selector '.govuk-hint', text: 'Textarea - Second - hint text'

    expect(find_field('page_textarea-second--textarea_auto_name_2').value).to eq 'Two'
    back

    # first
    expect(page).to have_selector '.fb-sectionHeading', text: 'Textarea - First - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Textarea - First'
    expect(page).to have_selector '.govuk-hint', text: 'Textarea - First - hint text'

    expect(find_field('page_textarea-first--textarea_auto_name_1').value).to eq 'One'
    back

    ########################################
    #                                      #
    #   START                              #
    #                                      #
    ########################################

    click_on 'Start'

    ########################################
    #                                      #
    #   FORWARD                            #
    #                                      #
    ########################################

    # first
    expect(page).to have_selector '.fb-sectionHeading', text: 'Textarea - First - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Textarea - First'
    expect(page).to have_selector '.govuk-hint', text: 'Textarea - First - hint text'

    expect(find_field('page_textarea-first--textarea_auto_name_1').value).to eq 'One'
    continue

    # second
    expect(page).to have_selector '.fb-sectionHeading', text: 'Textarea - Second - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Textarea - Second'
    expect(page).to have_selector '.govuk-hint', text: 'Textarea - Second - hint text'

    expect(find_field('page_textarea-second--textarea_auto_name_2').value).to eq 'Two'
    continue

    # third
    expect(page).to have_selector '.fb-sectionHeading', text: 'Textarea - Third - section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Textarea - Third'
    expect(page).to have_selector '.govuk-hint', text: 'Textarea - Third - hint text'

    expect(find_field('textarea-third').value).to eq 'One'
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector '.fb-sectionHeading', text: 'Textarea - Summary - section heading'
    expect(page).to have_selector 'h1', text: 'Summary'

    click_on 'Accept and send application'

    # confirmation
    expect(page).to have_selector 'h1.govuk-panel__title', text: 'Textarea - Confirmation'
  end

  def back
    find('.govuk-back-link').click
  end

  def continue
    click_on 'Continue'
  end
end
