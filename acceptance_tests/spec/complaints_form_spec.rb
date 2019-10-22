require 'capybara/rspec'
require 'spec_helper'

describe 'Filling out an Email output form' do
  it 'sends an email with the submission in a PDF' do
    visit 'http://runner-app:3000'

    click_on 'Start'
    fill_in 'First name', with: 'Bob'
    fill_in 'Last name', with: 'Smith'
    continue
    choose 'has-email', option: 'yes', visible: false
    continue
    fill_in 'Your email address', with: 'bob.smith@digital.justice.gov.uk'
    continue
    fill_in 'complaint_details', with: 'Some complaint details'
    continue
    choose 'has-complaint-documents', option: 'no', visible: false
    continue
    click_on 'Send complaint'
  end

  def continue
    click_on 'Continue'
  end
end
