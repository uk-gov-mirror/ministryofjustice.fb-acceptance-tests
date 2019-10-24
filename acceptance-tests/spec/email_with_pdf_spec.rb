require 'capybara/rspec'
require 'spec_helper'
require 'httparty'
require 'mail'
require 'pdf-reader'

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
    fill_in 'complaint_details', with: 'Foo bar baz'
    continue
    check 'Apples', visible: false
    continue
    click_on 'Send complaint'

    wait_for_email_and_assert_contents
  end

  def continue
    click_on 'Continue'
  end

  def wait_for_email_and_assert_contents
    begin
      response = HTTParty.get(ENV.fetch('EMAIL_ENDPOINT'))
      parsed_message = Mail.read_from_string(response.parsed_response['raw_message'])

      parsed_message.attachments.each do |attachment|
        File.open('/tmp/submission.pdf', 'w') { |file| file.write(attachment.decoded) }

        result = PDF::Reader.new('/tmp/submission.pdf').pages.map { |page| page.text }.join(' ')

        p 'Email Received.  Asserting PDF contents'
         expect(result).to include('This is a custom PDF Heading')
         expect(result).to include('Your name')
         expect(result).to include('First name               Bob')
         expect(result).to include('Last name                Smith')
         expect(result).to include('Can we contact you by')
         expect(result).to include('email?                   Yes')
         expect(result).to include('Your email address       bob.smith@digital.justice.gov.uk')
         expect(result).to include('Please tell us about yourFoo bar baz')
         expect(result).to include('Some Heading')
         expect(result).to include('Best Legend              Apples')
      end

    rescue
      p 'Waiting PDF to be generated...'
      sleep 2
      retry
    end
  end
end
