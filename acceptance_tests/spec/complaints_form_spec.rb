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

    begin
      response = HTTParty.get(ENV.fetch('RESULT_ENDPOINT'))
      result = response.body
      raw_message = response.parsed_response['raw_message']
      parsed_message = Mail.read_from_string(raw_message)
      parsed_message.attachments.each do |attachment|
        File.open('/tmp/submission.pdf', 'w') do |file|
          file.write(attachment.decoded)
        end

        reader = PDF::Reader.new('/tmp/submission.pdf')
        assert_result = reader.pages.map { |page| page.text }.join(' ')

        expect(assert_result).to include('bob.smith@digital.justice.gov.uk')
      end

    rescue HTTParty::Error => e
      sleep 2
      retry
    end
  end

  def continue
    click_on 'Continue'
  end
end
