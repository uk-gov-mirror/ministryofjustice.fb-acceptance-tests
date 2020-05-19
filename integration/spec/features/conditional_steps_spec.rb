require 'capybara/rspec'
require 'spec_helper'

describe 'Conditional steps' do
  let(:form) { FeaturesConditionalSteps.new }
  before { form.load }

  it 'Renders conditional steps (one)' do
    click_on 'Start'

    # radios
    expect(page).to have_selector '.fb-sectionHeading', text: 'Radios section heading'
    expect(page).to have_selector 'h1', text: 'Radios'
    expect(page).to have_selector '.govuk-hint', text: 'Radios hint text'

    choose 'auto_name__1', option: '1', visible: false
    continue

    # checkboxes
    expect(page).to have_selector '.fb-sectionHeading', text: 'Checkboxes section heading'
    expect(page).to have_selector 'h1', text: 'Checkboxes'
    expect(page).to have_selector '.govuk-hint', text: 'Checkboxes hint text'

    check 'auto_name__2', visible: false
    check 'auto_name__3', visible: false
    check 'auto_name__4', visible: false
    continue

    # email
    expect(page).to have_selector '.fb-sectionHeading', text: 'Email section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Email'
    expect(page).to have_selector '.govuk-hint', text: 'Email hint text'

    fill_in 'auto_name__5', with: "form-builder-developers@digital.justice.gov.uk"
    continue

    # number
    expect(page).to have_selector '.fb-sectionHeading', text: 'Number section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Number'
    expect(page).to have_selector '.govuk-hint', text: 'Number hint text'

    fill_in 'auto_name__6', with: "1"
    continue

    # text
    expect(page).to have_selector '.fb-sectionHeading', text: 'Text section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Text'
    expect(page).to have_selector '.govuk-hint', text: 'Text hint text'

    fill_in 'auto_name__7', with: "a"
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector '.fb-sectionHeading', text: 'Summary section heading'
    expect(page).to have_selector 'h1', text: 'Summary'

    expect(page).to have_selector 'h2:nth-of-type(1)', text: 'Radios section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Radios'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'One'

    expect(page).to have_selector 'h2:nth-of-type(2)', text: 'Checkboxes section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Checkboxes'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: /A\s*B\s*C/

    expect(page).to have_selector 'h2:nth-of-type(3)', text: 'Email section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Email'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'form-builder-developers@digital.justice.gov.uk'

    expect(page).to have_selector 'h2:nth-of-type(4)', text: 'Number section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Number'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: '1'

    expect(page).to have_selector 'h2:nth-of-type(5)', text: 'Text section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(5) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Text'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(5) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'a'
    click_on 'Accept and send application'

    # confirmation
    expect(page).to have_selector 'h1.govuk-panel__title', text: 'Confirmation'
  end

  it 'Renders conditional steps (two)' do
    click_on 'Start'

    # radios
    expect(page).to have_selector '.fb-sectionHeading', text: 'Radios section heading'
    expect(page).to have_selector 'h1', text: 'Radios'
    expect(page).to have_selector '.govuk-hint', text: 'Radios hint text'

    choose 'auto_name__1', option: '2', visible: false
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector '.fb-sectionHeading', text: 'Summary section heading'
    expect(page).to have_selector 'h1', text: 'Summary'

    expect(page).to have_selector 'h2:nth-of-type(1)', text: 'Radios section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Radios'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'Two'

    click_on 'Accept and send application'

    # confirmation
    expect(page).to have_selector 'h1.govuk-panel__title', text: 'Confirmation'
  end

  it 'Renders conditional steps (one) with change' do
    click_on 'Start'

    # radios
    expect(page).to have_selector '.fb-sectionHeading', text: 'Radios section heading'
    expect(page).to have_selector 'h1', text: 'Radios'
    expect(page).to have_selector '.govuk-hint', text: 'Radios hint text'

    choose 'auto_name__1', option: '1', visible: false
    continue

    # checkboxes
    expect(page).to have_selector '.fb-sectionHeading', text: 'Checkboxes section heading'
    expect(page).to have_selector 'h1', text: 'Checkboxes'
    expect(page).to have_selector '.govuk-hint', text: 'Checkboxes hint text'

    check 'auto_name__2', visible: false
    check 'auto_name__3', visible: false
    check 'auto_name__4', visible: false
    continue

    # email
    expect(page).to have_selector '.fb-sectionHeading', text: 'Email section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Email'
    expect(page).to have_selector '.govuk-hint', text: 'Email hint text'

    fill_in 'auto_name__5', with: "form-builder-developers@digital.justice.gov.uk"
    continue

    # number
    expect(page).to have_selector '.fb-sectionHeading', text: 'Number section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Number'
    expect(page).to have_selector '.govuk-hint', text: 'Number hint text'

    fill_in 'auto_name__6', with: "1"
    continue

    # text
    expect(page).to have_selector '.fb-sectionHeading', text: 'Text section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Text'
    expect(page).to have_selector '.govuk-hint', text: 'Text hint text'

    fill_in 'auto_name__7', with: "a"
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector '.fb-sectionHeading', text: 'Summary section heading'
    expect(page).to have_selector 'h1', text: 'Summary'

    expect(page).to have_selector 'h2:nth-of-type(1)', text: 'Radios section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Radios'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'One'

    expect(page).to have_selector 'h2:nth-of-type(2)', text: 'Checkboxes section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Checkboxes'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: /A\s*B\s*C/

    expect(page).to have_selector 'h2:nth-of-type(3)', text: 'Email section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Email'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'form-builder-developers@digital.justice.gov.uk'

    expect(page).to have_selector 'h2:nth-of-type(4)', text: 'Number section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Number'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: '1'

    expect(page).to have_selector 'h2:nth-of-type(5)', text: 'Text section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(5) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Text'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(5) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'a'

    ########################################
    #                                      #
    #   CHANGE                             #
    #                                      #
    ########################################

    # change
    find('.govuk-summary-list:nth-of-type(2) .govuk-summary-list__actions a').click

    # checkboxes
    expect(page).to have_selector '.fb-sectionHeading', text: 'Checkboxes section heading'
    expect(page).to have_selector 'h1', text: 'Checkboxes'
    expect(page).to have_selector '.govuk-hint', text: 'Checkboxes hint text'

    check 'auto_name__2', visible: false
    check 'auto_name__3', visible: false
    uncheck 'auto_name__4', visible: false
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector '.fb-sectionHeading', text: 'Summary section heading'
    expect(page).to have_selector 'h1', text: 'Summary'

    expect(page).to have_selector 'h2:nth-of-type(1)', text: 'Radios section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Radios'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'One'

    expect(page).to have_selector 'h2:nth-of-type(2)', text: 'Checkboxes section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Checkboxes'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: /A\s*B/

    expect(page).to have_selector 'h2:nth-of-type(3)', text: 'Email section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Email'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'form-builder-developers@digital.justice.gov.uk'

    expect(page).to have_selector 'h2:nth-of-type(4)', text: 'Number section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Number'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: '1'

    ########################################
    #                                      #
    #   CHANGE                             #
    #                                      #
    ########################################

    # change
    find('.govuk-summary-list:nth-of-type(2) .govuk-summary-list__actions a').click

    # checkboxes
    expect(page).to have_selector '.fb-sectionHeading', text: 'Checkboxes section heading'
    expect(page).to have_selector 'h1', text: 'Checkboxes'
    expect(page).to have_selector '.govuk-hint', text: 'Checkboxes hint text'

    check 'auto_name__2', visible: false
    uncheck 'auto_name__3', visible: false
    uncheck 'auto_name__4', visible: false
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector '.fb-sectionHeading', text: 'Summary section heading'
    expect(page).to have_selector 'h1', text: 'Summary'

    expect(page).to have_selector 'h2:nth-of-type(1)', text: 'Radios section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Radios'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'One'

    expect(page).to have_selector 'h2:nth-of-type(2)', text: 'Checkboxes section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Checkboxes'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'A'

    ########################################
    #                                      #
    #   CHANGE                             #
    #                                      #
    ########################################

    # change
    find('.govuk-summary-list:nth-of-type(2) .govuk-summary-list__actions a').click

    # checkboxes
    expect(page).to have_selector '.fb-sectionHeading', text: 'Checkboxes section heading'
    expect(page).to have_selector 'h1', text: 'Checkboxes'
    expect(page).to have_selector '.govuk-hint', text: 'Checkboxes hint text'

    uncheck 'auto_name__2', visible: false
    uncheck 'auto_name__3', visible: false
    uncheck 'auto_name__4', visible: false
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector '.fb-sectionHeading', text: 'Summary section heading'
    expect(page).to have_selector 'h1', text: 'Summary'

    expect(page).to have_selector 'h2:nth-of-type(1)', text: 'Radios section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Radios'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'One'

    expect(page).to have_selector 'h2:nth-of-type(2)', text: 'Checkboxes section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Checkboxes'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'Not answered'

    click_on 'Accept and send application'

    # confirmation
    expect(page).to have_selector 'h1.govuk-panel__title', text: 'Confirmation'
  end

  it 'Renders conditional steps (one) with back' do
    click_on 'Start'

    # radios
    expect(page).to have_selector '.fb-sectionHeading', text: 'Radios section heading'
    expect(page).to have_selector 'h1', text: 'Radios'
    expect(page).to have_selector '.govuk-hint', text: 'Radios hint text'

    choose 'auto_name__1', option: '1', visible: false
    continue

    # checkboxes
    expect(page).to have_selector '.fb-sectionHeading', text: 'Checkboxes section heading'
    expect(page).to have_selector 'h1', text: 'Checkboxes'
    expect(page).to have_selector '.govuk-hint', text: 'Checkboxes hint text'

    check 'auto_name__2', visible: false
    check 'auto_name__3', visible: false
    check 'auto_name__4', visible: false
    continue

    # email
    expect(page).to have_selector '.fb-sectionHeading', text: 'Email section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Email'
    expect(page).to have_selector '.govuk-hint', text: 'Email hint text'

    fill_in 'auto_name__5', with: "form-builder-developers@digital.justice.gov.uk"
    continue

    # number
    expect(page).to have_selector '.fb-sectionHeading', text: 'Number section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Number'
    expect(page).to have_selector '.govuk-hint', text: 'Number hint text'

    fill_in 'auto_name__6', with: "1"
    continue

    # text
    expect(page).to have_selector '.fb-sectionHeading', text: 'Text section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Text'
    expect(page).to have_selector '.govuk-hint', text: 'Text hint text'

    fill_in 'auto_name__7', with: "a"
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector '.fb-sectionHeading', text: 'Summary section heading'
    expect(page).to have_selector 'h1', text: 'Summary'

    expect(page).to have_selector 'h2:nth-of-type(1)', text: 'Radios section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Radios'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'One'

    expect(page).to have_selector 'h2:nth-of-type(2)', text: 'Checkboxes section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Checkboxes'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: /A\s*B\s*C/

    expect(page).to have_selector 'h2:nth-of-type(3)', text: 'Email section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Email'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'form-builder-developers@digital.justice.gov.uk'

    expect(page).to have_selector 'h2:nth-of-type(4)', text: 'Number section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Number'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: '1'

    expect(page).to have_selector 'h2:nth-of-type(5)', text: 'Text section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(5) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Text'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(5) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'a'

    ########################################
    #                                      #
    #   BACK                               #
    #                                      #
    ########################################

    # back
    back

    # text
    expect(page).to have_selector '.fb-sectionHeading', text: 'Text section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Text'
    expect(page).to have_selector '.govuk-hint', text: 'Text hint text'

    ########################################
    #                                      #
    #   BACK                               #
    #                                      #
    ########################################

    # back
    back

    # number
    expect(page).to have_selector '.fb-sectionHeading', text: 'Number section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Number'
    expect(page).to have_selector '.govuk-hint', text: 'Number hint text'

    ########################################
    #                                      #
    #   BACK                               #
    #                                      #
    ########################################

    # back
    back

    # email
    expect(page).to have_selector '.fb-sectionHeading', text: 'Email section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Email'
    expect(page).to have_selector '.govuk-hint', text: 'Email hint text'

    ########################################
    #                                      #
    #   BACK                               #
    #                                      #
    ########################################

    # back
    back

    # checkboxes
    expect(page).to have_selector '.fb-sectionHeading', text: 'Checkboxes section heading'
    expect(page).to have_selector 'h1', text: 'Checkboxes'
    expect(page).to have_selector '.govuk-hint', text: 'Checkboxes hint text'

    check 'auto_name__2', visible: false
    check 'auto_name__3', visible: false
    uncheck 'auto_name__4', visible: false
    continue

    # email
    expect(page).to have_selector '.fb-sectionHeading', text: 'Email section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Email'
    expect(page).to have_selector '.govuk-hint', text: 'Email hint text'
    continue

    # number
    expect(page).to have_selector '.fb-sectionHeading', text: 'Number section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Number'
    expect(page).to have_selector '.govuk-hint', text: 'Number hint text'
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector '.fb-sectionHeading', text: 'Summary section heading'
    expect(page).to have_selector 'h1', text: 'Summary'

    expect(page).to have_selector 'h2:nth-of-type(1)', text: 'Radios section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Radios'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'One'

    expect(page).to have_selector 'h2:nth-of-type(2)', text: 'Checkboxes section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Checkboxes'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: /A\s*B/

    expect(page).to have_selector 'h2:nth-of-type(3)', text: 'Email section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Email'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'form-builder-developers@digital.justice.gov.uk'

    expect(page).to have_selector 'h2:nth-of-type(4)', text: 'Number section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Number'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: '1'

    ########################################
    #                                      #
    #   BACK                               #
    #                                      #
    ########################################

    # back
    back

    # number
    expect(page).to have_selector '.fb-sectionHeading', text: 'Number section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Number'
    expect(page).to have_selector '.govuk-hint', text: 'Number hint text'

    ########################################
    #                                      #
    #   BACK                               #
    #                                      #
    ########################################

    # back
    back

    # email
    expect(page).to have_selector '.fb-sectionHeading', text: 'Email section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Email'
    expect(page).to have_selector '.govuk-hint', text: 'Email hint text'

    ########################################
    #                                      #
    #   BACK                               #
    #                                      #
    ########################################

    # back
    back

    # checkboxes
    expect(page).to have_selector '.fb-sectionHeading', text: 'Checkboxes section heading'
    expect(page).to have_selector 'h1', text: 'Checkboxes'
    expect(page).to have_selector '.govuk-hint', text: 'Checkboxes hint text'

    check 'auto_name__2', visible: false
    uncheck 'auto_name__3', visible: false
    uncheck 'auto_name__4', visible: false
    continue

    # email
    expect(page).to have_selector '.fb-sectionHeading', text: 'Email section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Email'
    expect(page).to have_selector '.govuk-hint', text: 'Email hint text'
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector '.fb-sectionHeading', text: 'Summary section heading'
    expect(page).to have_selector 'h1', text: 'Summary'

    expect(page).to have_selector 'h2:nth-of-type(1)', text: 'Radios section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Radios'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'One'

    expect(page).to have_selector 'h2:nth-of-type(2)', text: 'Checkboxes section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Checkboxes'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'A'

    ########################################
    #                                      #
    #   BACK                               #
    #                                      #
    ########################################

    # back
    back

    # email
    expect(page).to have_selector '.fb-sectionHeading', text: 'Email section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Email'
    expect(page).to have_selector '.govuk-hint', text: 'Email hint text'

    ########################################
    #                                      #
    #   BACK                               #
    #                                      #
    ########################################

    # back
    back

    # checkboxes
    expect(page).to have_selector '.fb-sectionHeading', text: 'Checkboxes section heading'
    expect(page).to have_selector 'h1', text: 'Checkboxes'
    expect(page).to have_selector '.govuk-hint', text: 'Checkboxes hint text'

    uncheck 'auto_name__2', visible: false
    uncheck 'auto_name__3', visible: false
    uncheck 'auto_name__4', visible: false
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector '.fb-sectionHeading', text: 'Summary section heading'
    expect(page).to have_selector 'h1', text: 'Summary'

    expect(page).to have_selector 'h2:nth-of-type(1)', text: 'Radios section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Radios'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'One'

    expect(page).to have_selector 'h2:nth-of-type(2)', text: 'Checkboxes section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Checkboxes'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'Not answered'

    click_on 'Accept and send application'

    # confirmation
    expect(page).to have_selector 'h1.govuk-panel__title', text: 'Confirmation'
  end

  it 'Renders conditional steps (two) with change' do
    click_on 'Start'

    # radios
    expect(page).to have_selector '.fb-sectionHeading', text: 'Radios section heading'
    expect(page).to have_selector 'h1', text: 'Radios'
    expect(page).to have_selector '.govuk-hint', text: 'Radios hint text'

    choose 'auto_name__1', option: '2', visible: false
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector '.fb-sectionHeading', text: 'Summary section heading'
    expect(page).to have_selector 'h1', text: 'Summary'

    expect(page).to have_selector 'h2:nth-of-type(1)', text: 'Radios section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Radios'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'Two'

    ########################################
    #                                      #
    #   CHANGE                             #
    #                                      #
    ########################################

    # change
    find('.govuk-summary-list:nth-of-type(1) .govuk-summary-list__actions a').click

    # radios
    expect(page).to have_selector '.fb-sectionHeading', text: 'Radios section heading'
    expect(page).to have_selector 'h1', text: 'Radios'
    expect(page).to have_selector '.govuk-hint', text: 'Radios hint text'

    choose 'auto_name__1', option: '1', visible: false
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector '.fb-sectionHeading', text: 'Summary section heading'
    expect(page).to have_selector 'h1', text: 'Summary'

    expect(page).to have_selector 'h2:nth-of-type(1)', text: 'Radios section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Radios'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'One'

    expect(page).to have_selector 'h2:nth-of-type(2)', text: 'Checkboxes section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Checkboxes'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'Not answered'

    # change
    find('.govuk-summary-list:nth-of-type(2) .govuk-summary-list__actions a').click

    # checkboxes
    expect(page).to have_selector '.fb-sectionHeading', text: 'Checkboxes section heading'
    expect(page).to have_selector 'h1', text: 'Checkboxes'
    expect(page).to have_selector '.govuk-hint', text: 'Checkboxes hint text'

    check 'auto_name__2', visible: false
    check 'auto_name__3', visible: false
    check 'auto_name__4', visible: false
    continue

    # email
    expect(page).to have_selector '.fb-sectionHeading', text: 'Email section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Email'
    expect(page).to have_selector '.govuk-hint', text: 'Email hint text'

    fill_in 'auto_name__5', with: "form-builder-developers@digital.justice.gov.uk"
    continue

    # number
    expect(page).to have_selector '.fb-sectionHeading', text: 'Number section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Number'
    expect(page).to have_selector '.govuk-hint', text: 'Number hint text'

    fill_in 'auto_name__6', with: "1"
    continue

    # text
    expect(page).to have_selector '.fb-sectionHeading', text: 'Text section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Text'
    expect(page).to have_selector '.govuk-hint', text: 'Text hint text'

    fill_in 'auto_name__7', with: "a"
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector '.fb-sectionHeading', text: 'Summary section heading'
    expect(page).to have_selector 'h1', text: 'Summary'

    expect(page).to have_selector 'h2:nth-of-type(1)', text: 'Radios section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Radios'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'One'

    expect(page).to have_selector 'h2:nth-of-type(2)', text: 'Checkboxes section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Checkboxes'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: /A\s*B\s*C/

    expect(page).to have_selector 'h2:nth-of-type(3)', text: 'Email section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Email'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'form-builder-developers@digital.justice.gov.uk'

    expect(page).to have_selector 'h2:nth-of-type(4)', text: 'Number section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Number'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: '1'

    expect(page).to have_selector 'h2:nth-of-type(5)', text: 'Text section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(5) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Text'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(5) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'a'

    # change
    find('.govuk-summary-list:nth-of-type(1) .govuk-summary-list__actions a').click

    # radios
    expect(page).to have_selector '.fb-sectionHeading', text: 'Radios section heading'
    expect(page).to have_selector 'h1', text: 'Radios'
    expect(page).to have_selector '.govuk-hint', text: 'Radios hint text'

    choose 'auto_name__1', option: '2', visible: false
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector '.fb-sectionHeading', text: 'Summary section heading'
    expect(page).to have_selector 'h1', text: 'Summary'

    expect(page).to have_selector 'h2:nth-of-type(1)', text: 'Radios section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Radios'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'Two'

    expect(page).to have_selector 'h2:nth-of-type(2)', text: 'Email section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Email'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'form-builder-developers@digital.justice.gov.uk'

    expect(page).to have_selector 'h2:nth-of-type(3)', text: 'Number section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Number'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: '1'

    expect(page).to have_selector 'h2:nth-of-type(4)', text: 'Text section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Text'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'a'

    click_on 'Accept and send application'

    # confirmation
    expect(page).to have_selector 'h1.govuk-panel__title', text: 'Confirmation'
  end

  it 'Renders conditional steps (two) with back' do
    click_on 'Start'

    # radios
    expect(page).to have_selector '.fb-sectionHeading', text: 'Radios section heading'
    expect(page).to have_selector 'h1', text: 'Radios'
    expect(page).to have_selector '.govuk-hint', text: 'Radios hint text'

    choose 'auto_name__1', option: '2', visible: false
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector '.fb-sectionHeading', text: 'Summary section heading'
    expect(page).to have_selector 'h1', text: 'Summary'

    expect(page).to have_selector 'h2:nth-of-type(1)', text: 'Radios section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Radios'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'Two'

    ########################################
    #                                      #
    #   BACK                               #
    #                                      #
    ########################################

    # back
    back

    # radios
    expect(page).to have_selector '.fb-sectionHeading', text: 'Radios section heading'
    expect(page).to have_selector 'h1', text: 'Radios'
    expect(page).to have_selector '.govuk-hint', text: 'Radios hint text'

    choose 'auto_name__1', option: '1', visible: false
    continue

    # checkboxes
    expect(page).to have_selector '.fb-sectionHeading', text: 'Checkboxes section heading'
    expect(page).to have_selector 'h1', text: 'Checkboxes'
    expect(page).to have_selector '.govuk-hint', text: 'Checkboxes hint text'

    check 'auto_name__2', visible: false
    check 'auto_name__3', visible: false
    check 'auto_name__4', visible: false
    continue

    # email
    expect(page).to have_selector '.fb-sectionHeading', text: 'Email section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Email'
    expect(page).to have_selector '.govuk-hint', text: 'Email hint text'

    fill_in 'auto_name__5', with: "form-builder-developers@digital.justice.gov.uk"
    continue

    # number
    expect(page).to have_selector '.fb-sectionHeading', text: 'Number section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Number'
    expect(page).to have_selector '.govuk-hint', text: 'Number hint text'

    fill_in 'auto_name__6', with: "1"
    continue

    # text
    expect(page).to have_selector '.fb-sectionHeading', text: 'Text section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Text'
    expect(page).to have_selector '.govuk-hint', text: 'Text hint text'

    fill_in 'auto_name__7', with: "a"
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector '.fb-sectionHeading', text: 'Summary section heading'
    expect(page).to have_selector 'h1', text: 'Summary'

    expect(page).to have_selector 'h2:nth-of-type(1)', text: 'Radios section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Radios'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'One'

    expect(page).to have_selector 'h2:nth-of-type(2)', text: 'Checkboxes section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Checkboxes'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: /A\s*B\s*C/

    expect(page).to have_selector 'h2:nth-of-type(3)', text: 'Email section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Email'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'form-builder-developers@digital.justice.gov.uk'

    expect(page).to have_selector 'h2:nth-of-type(4)', text: 'Number section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Number'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: '1'

    expect(page).to have_selector 'h2:nth-of-type(5)', text: 'Text section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(5) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Text'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(5) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'a'

    ########################################
    #                                      #
    #   BACK                               #
    #                                      #
    ########################################

    # back
    back

    # text
    expect(page).to have_selector '.fb-sectionHeading', text: 'Text section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Text'
    expect(page).to have_selector '.govuk-hint', text: 'Text hint text'

    ########################################
    #                                      #
    #   BACK                               #
    #                                      #
    ########################################

    # back
    back

    # number
    expect(page).to have_selector '.fb-sectionHeading', text: 'Number section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Number'
    expect(page).to have_selector '.govuk-hint', text: 'Number hint text'

    ########################################
    #                                      #
    #   BACK                               #
    #                                      #
    ########################################

    # back
    back

    # email
    expect(page).to have_selector '.fb-sectionHeading', text: 'Email section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Email'
    expect(page).to have_selector '.govuk-hint', text: 'Email hint text'

    ########################################
    #                                      #
    #   BACK                               #
    #                                      #
    ########################################

    # back
    back

    # checkboxes
    expect(page).to have_selector '.fb-sectionHeading', text: 'Checkboxes section heading'
    expect(page).to have_selector 'h1', text: 'Checkboxes'
    expect(page).to have_selector '.govuk-hint', text: 'Checkboxes hint text'

    check 'auto_name__2', visible: false
    check 'auto_name__3', visible: false
    uncheck 'auto_name__4', visible: false
    continue

    # email
    expect(page).to have_selector '.fb-sectionHeading', text: 'Email section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Email'
    expect(page).to have_selector '.govuk-hint', text: 'Email hint text'
    continue

    # number
    expect(page).to have_selector '.fb-sectionHeading', text: 'Number section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Number'
    expect(page).to have_selector '.govuk-hint', text: 'Number hint text'
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector '.fb-sectionHeading', text: 'Summary section heading'
    expect(page).to have_selector 'h1', text: 'Summary'

    expect(page).to have_selector 'h2:nth-of-type(1)', text: 'Radios section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Radios'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'One'

    expect(page).to have_selector 'h2:nth-of-type(2)', text: 'Checkboxes section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Checkboxes'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: /A\s*B/

    expect(page).to have_selector 'h2:nth-of-type(3)', text: 'Email section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Email'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'form-builder-developers@digital.justice.gov.uk'

    expect(page).to have_selector 'h2:nth-of-type(4)', text: 'Number section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Number'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(4) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: '1'

    ########################################
    #                                      #
    #   BACK                               #
    #                                      #
    ########################################

    # back
    back

    # number
    expect(page).to have_selector '.fb-sectionHeading', text: 'Number section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Number'
    expect(page).to have_selector '.govuk-hint', text: 'Number hint text'

    ########################################
    #                                      #
    #   BACK                               #
    #                                      #
    ########################################

    # back
    back

    # email
    expect(page).to have_selector '.fb-sectionHeading', text: 'Email section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Email'
    expect(page).to have_selector '.govuk-hint', text: 'Email hint text'

    ########################################
    #                                      #
    #   BACK                               #
    #                                      #
    ########################################

    # back
    back

    # checkboxes
    expect(page).to have_selector '.fb-sectionHeading', text: 'Checkboxes section heading'
    expect(page).to have_selector 'h1', text: 'Checkboxes'
    expect(page).to have_selector '.govuk-hint', text: 'Checkboxes hint text'

    check 'auto_name__2', visible: false
    uncheck 'auto_name__3', visible: false
    uncheck 'auto_name__4', visible: false
    continue

    # email
    expect(page).to have_selector '.fb-sectionHeading', text: 'Email section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Email'
    expect(page).to have_selector '.govuk-hint', text: 'Email hint text'
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector '.fb-sectionHeading', text: 'Summary section heading'
    expect(page).to have_selector 'h1', text: 'Summary'

    expect(page).to have_selector 'h2:nth-of-type(1)', text: 'Radios section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Radios'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'One'

    expect(page).to have_selector 'h2:nth-of-type(2)', text: 'Checkboxes section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Checkboxes'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'A'

    expect(page).to have_selector 'h2:nth-of-type(3)', text: 'Email section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Email'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(3) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'form-builder-developers@digital.justice.gov.uk'

    ########################################
    #                                      #
    #   BACK                               #
    #                                      #
    ########################################

    # back
    back

    # email
    expect(page).to have_selector '.fb-sectionHeading', text: 'Email section heading'
    expect(page).to have_selector 'h1 label.govuk-label', text: 'Email'
    expect(page).to have_selector '.govuk-hint', text: 'Email hint text'

    ########################################
    #                                      #
    #   BACK                               #
    #                                      #
    ########################################

    # back
    back

    # checkboxes
    expect(page).to have_selector '.fb-sectionHeading', text: 'Checkboxes section heading'
    expect(page).to have_selector 'h1', text: 'Checkboxes'
    expect(page).to have_selector '.govuk-hint', text: 'Checkboxes hint text'

    uncheck 'auto_name__2', visible: false
    uncheck 'auto_name__3', visible: false
    uncheck 'auto_name__4', visible: false
    continue

    ########################################
    #                                      #
    #   SUMMARY                            #
    #                                      #
    ########################################

    # summary
    expect(page).to have_selector '.fb-sectionHeading', text: 'Summary section heading'
    expect(page).to have_selector 'h1', text: 'Summary'

    expect(page).to have_selector 'h2:nth-of-type(1)', text: 'Radios section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Radios'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(1) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'One'

    expect(page).to have_selector 'h2:nth-of-type(2)', text: 'Checkboxes section heading'

    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__key', text: 'Checkboxes'
    expect(page).to have_selector '.govuk-summary-list:nth-of-type(2) .govuk-summary-list__row:nth-of-type(1) .govuk-summary-list__value', text: 'Not answered'

    click_on 'Accept and send application'

    # confirmation
    expect(page).to have_selector 'h1.govuk-panel__title', text: 'Confirmation'
  end

  def back
    find('.govuk-back-link').click
  end

  def continue
    click_on 'Continue'
  end
end
