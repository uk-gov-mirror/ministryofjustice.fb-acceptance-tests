require 'capybara/rspec'
require 'spec_helper'
require 'httparty'
require 'jwe'
require 'open-uri'

describe 'JSON Output' do
  before :each do
    OutputRecorder.cleanup_recorded_requests
  end

  it 'sends the JSON payload to the specified endpoint' do
    visit 'http://features-json-app:3000'
    click_on 'Start'

    # text
    fill_in 'First name', with: 'Form'
    fill_in 'Last name', with: 'Builders'
    continue

    # radio
    choose 'has_email', option: 'yes', visible: false
    continue

    # email
    fill_in 'Your email address', with: 'form-builder-developers@digital.justice.gov.uk'
    continue

    # text
    fill_in 'cat_details', with: 'My cat is a fluffy killer'
    continue

    # checkbox
    check 'Apples', visible: false
    continue

    # date
    fill_in 'COMPOSITE.date-day', with: '12'
    fill_in 'COMPOSITE.date-month', with: '11'
    fill_in 'COMPOSITE.date-year', with: '2007'
    continue

    # number
    fill_in 'number_cats', with: 28
    continue

    # select
    select "I can't say (They can read)", from: 'cat_spy'
    continue

    # autocomplete
    fill_in 'page_autocomplete--autocomplete_autocomplete', with: "California Spangled\n" # the new line "presses enter" on the selected option
    continue

    # upload
    attach_file("cat_picture[1]", 'spec/fixtures/files/hello_world.txt')
    continue

    # upload check
    choose 'upload-component-decision', option: 'accept', visible: false
    continue

    click_on 'Send complaint'

    expect(page).to have_content("You've sent us the answers about your cat!")

    results = OutputRecorder.wait_for_result(url: '/json')
    expect(results.size).to eq(1)

    encrypted_result = results.first

    result = JSON.parse(JWE.decrypt(encrypted_result, ENV.fetch('SERVICE_OUTPUT_JSON_KEY')), symbolize_names: true)
    submission_answers_without_upload = result[:submissionAnswers].reject { |k, _| k == :cat_picture }
    uploads = result[:submissionAnswers][:cat_picture]
    upload = result[:submissionAnswers][:cat_picture][0]

    expect(result).to include(serviceSlug: 'slug')
    expect(submission_answers_without_upload).to eql(
      first_name: 'Form',
      last_name: 'Builders',
      has_email: 'yes',
      email_address: 'form-builder-developers@digital.justice.gov.uk',
      cat_details: 'My cat is a fluffy killer',
      date: '2007-11-12',
      number_cats: 28,
      cat_spy: 'machine answer 3',
      cat_breed: 'California Spangled',
      checkbox_apples: 'Apples'
    )

    expect(submission_answers_without_upload.size).to eql(10)
    expect(uploads.size).to eql(1)

    four_weeks = 28 * 24 * 60 * 60
    expect(Time.at(upload[:date])).to be_within(300).of(Time.at(Time.now.to_i + four_weeks))
    expect(upload[:destination]).to eql('/tmp/uploads')
    expect(upload[:encoding]).to eql('7bit')
    expect(upload[:fieldname]).to eql('cat_picture[1]')
    expect(upload[:filename].size).to be > 0
    expect(upload[:fingerprint]).to eql('28d-a948904f2f0f479b8f8197694b30184b0d2ed1c1cd2a1ec0fb85d299a192a447')
    expect(upload[:maxSize]).to eql(5_242_880)
    expect(upload[:mimetype]).to eql('text/plain')
    expect(upload[:originalname]).to eql('hello_world.txt')
    expect(upload[:path]).to match(%r{/tmp/uploads/\S{32}})
    expect(upload[:size]).to eql(12)
    expect(upload[:type]).to eql('text/plain')
    expect(upload[:url]).to match(%r{http://filestore-app:3000/service/slug/user/\S{36}/28d-\S{64}})
    expect(upload[:uuid]).to match(/\S{36}/)

    expect(result[:attachments].size).to eql(1)
    expect(result[:attachments][0][:encryption_iv].size).to eql(24)
    expect(result[:attachments][0][:encryption_key].size).to eql(44)
    expect(result[:attachments][0][:filename]).to eql('hello_world.txt')
    expect(result[:attachments][0][:mimetype]).to eql('text/plain')
    expect(result[:attachments][0][:url].size).to eql(337)

    file_contents = open(result[:attachments][0][:url], 'rb').read

    crypto = Cryptography.new(encryption_key: Base64.strict_decode64(result[:attachments][0][:encryption_key]),
                              encryption_iv: Base64.strict_decode64(result[:attachments][0][:encryption_iv]))

    decrypted_file_contents = crypto.decrypt(file: file_contents)

    expect(decrypted_file_contents).to eql("hello world\n")

    expect(result).to have_key(:submissionId)
  end

  def continue
    click_on 'Continue'
  end
end
