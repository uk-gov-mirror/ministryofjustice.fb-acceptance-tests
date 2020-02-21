require 'capybara/rspec'
require 'spec_helper'

describe 'Using Save and Return' do
  it 'puts a link onto the start page' do
    visit 'http://runner-app:3000'

    # Save and Return "Continue work on a saved form"
    expect(page).to have_selector 'p a[href="/return"]', text: 'Continue work on a saved form'
  end

  it 'puts a save and return button into the form' do
    visit 'http://runner-app:3000'
    click_on 'Start'

    expect(page).to have_selector 'button[name="setupReturn"]', text: 'Save and come back later'
  end

  it 'puts a save and return message into the page' do
    visit 'http://runner-app:3000'
    click_on 'Start'

    expect(page).to have_selector 'p', text: /Your session will time out after \d+ minutes of inactivity/
    expect(page).to have_selector 'p', text: 'Save your details if you want to come back later'
  end

  it 'sets up save and return' do
    visit 'http://runner-app:3000'
    click_on 'Start'

    # Save and Return "Save and come back later"
    find('button[name="setupReturn"]').click

    expect(page).to have_selector 'h1', text: 'Saving your progress'
    continue

    expect(page).to have_selector 'h1', text: 'Save your progress'
    expect(page).to have_selector 'form label', text: 'Email address'

    # email
    fill_in 'email', with: "form-builder-developers@digital.justice.gov.uk"
    continue

    expect(page).to have_selector 'h1', text: 'Check your email'
    expect(page).to have_selector 'h1 + p', text: 'We have sent an email to form-builder-developers@digital.justice.gov.uk.'
  end

  it 'puts a continue link onto the start page' do
    visit 'http://runner-app:3000'

    # Save and Return "Continue work on a saved form"
    find('p a[href="/return"]').click

    # Save and Return start
    expect(page).to have_selector 'h1', text: 'Get a sign-in link'
    expect(page).to have_selector 'form label', text: 'Email address'
  end

  # it 'accepts an email address' do
  #   visit 'http://runner-app:3000'

  #   # Save and Return "Continue work on a saved form"
  #   find('p a[href="/return"]').click

  #   # Save and Return start
  #   expect(page).to have_selector 'h1', text: 'Get a sign-in link'
  #   expect(page).to have_selector 'form label', text: 'Email address'

  #   # email
  #   fill_in 'email', with: "form-builder-developers@digital.justice.gov.uk"
  #   continue

  #   expect(page).to have_selector 'h1', text: 'Check your email'
  #   expect(page).to have_selector 'h1 + p', text: "We’ve sent your sign-in link to form-builder-developers@digital.justice.gov.uk"

  #   expect(page).to have_selector 'h2', text: 'Didn’t receive the email?'
  #   expect(page).to have_selector 'ul li a[href="/return/form-builder-developers@digital.justice.gov.uk"]', text: 'resend the email'

  #   find('ul li a[href="/return/form-builder-developers@digital.justice.gov.uk"]').click

  #   expect(page).to have_selector 'h1', text: 'Get a sign-in link'
  #   expect(page).to have_selector 'form label', text: 'Email address'
  # end

  it 'rejects no email address' do
    visit 'http://runner-app:3000'

    # Save and Return "Continue work on a saved form"
    find('p a[href="/return"]').click

    # Save and Return start
    expect(page).to have_selector 'h1', text: 'Get a sign-in link'
    expect(page).to have_selector 'form label', text: 'Email address'

    # email
    fill_in 'email', with: "" # ensure empty
    continue

    expect(page).to have_selector 'h1', text: 'Get a sign-in link'
    expect(page).to have_selector '.govuk-error-summary a[href="#return_start_email"]', text: 'Enter an email address for Email address'
    expect(page).to have_selector '.govuk-error-message', text: 'Enter an email address for Email address'
  end

  def continue
    click_on 'Continue'
  end
end
