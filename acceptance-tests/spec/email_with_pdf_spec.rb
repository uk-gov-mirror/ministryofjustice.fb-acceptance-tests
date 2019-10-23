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
    fill_in 'complaint_details', with: 'Some complaint details'
    continue
    choose 'has-complaint-documents', option: 'no', visible: false
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

        expected_result = <<-HEREDOC
 Complain about a court or tribunal



 Your name




 First name                Bob


 Last name                 Smith



 Can we contact you about
                           Yes
 your complaint by email?

 Your email address        bob.smith@digital.justice.gov.uk


 Your complaint            Some complaint details


 Would you like to send any
 documents as part of your No
 complaint?
HEREDOC
        expect(result).to include(expected_result)
      end

    rescue HTTParty::Error => e
      p 'Waiting for email to be delivered...'
      sleep 2
      retry
    end
  end
end
