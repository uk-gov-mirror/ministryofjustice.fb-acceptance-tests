require 'pdf-reader'

describe 'New Runner' do
  let(:form) { NewRunnerApp.new }
  before :each do
    OutputRecorder.cleanup_recorded_requests if ENV['CI_MODE'].blank?
  end
  let(:generated_name) { "FN-#{SecureRandom.uuid}" }

  it 'sends an email with the submission in a PDF' do
    form.load
    form.start_button.click
    form.first_name_field.set('Stormtrooper')
    form.last_name_field.set(generated_name)
    continue

    form.email_field.set('fb-acceptance-tests@digital.justice.gov.uk')
    continue

    # text
    fill_in 'Your cat',
      with: 'My cat is a fluffy killer £ % ~ ! @ # $ ^ * ( ) - _ = + [ ] | ; , . ?'
    continue

    # checkbox
    form.apples_field.check
    form.pears_field.check
    continue

    # date
    form.day_field.set('12')
    form.month_field.set('11')
    form.year_field.set('2007')
    continue

    # number
    form.number_cats_field.set(28)
    continue

    # radio
    form.yes_field.choose
    continue

    # check your answers
    expect(page.text).to include('First name Stormtrooper')
    expect(page.text).to include("Last name #{generated_name}")
    expect(page.text).to include('Your email address fb-acceptance-tests@digital.justice.gov.uk')
    expect(page.text).to include('Your cat My cat is a fluffy killer £ % ~ ! @ # $ ^ * ( ) - _ = + [ ] | ; , . ?')
    expect(page.text).to include("Your fruit Apples\nPears")
    expect(page.text).to include('12 November 2007')
    expect(page.text).to include('How many cats have chosen you? 28')
    expect(page.text).to include('Is your cat watching you now? Yes')

    click_on 'Accept and send application'

    expect(form.text).to include("You've sent us the answers about your cat!")

    attachments = find_attachments(id: generated_name)

    require 'byebug'
    byebug
    assert_pdf_contents(attachments[:pdf_answers])
  end

  def continue
    form.continue_button.click
  end

  def parse_email(email)
    url_decoded_hash = CGI::parse(email)
    Mail.read_from_string(url_decoded_hash.fetch('raw_message'))
  end

  def assert_pdf_contents(attachments)
    pdf_path = "/tmp/submission-#{SecureRandom.uuid}.pdf"
    File.open(pdf_path, 'w') do |file|
      file.write(attachments[:pdf_answers])
    end
    result = PDF::Reader.new(pdf_path).pages.map do |page|
      page.text
    end.join(' ')
    p 'Asserting PDF contents'

    expect(result).to include('Subheading for new acceptance tests')
    expect(result).to include('Submission for New Acceptance tests Email Output')

    # text
    expect(result).to include('Your name')
    expect(result).to match(/First name[\n\r\s]+Stormtrooper/)
    expect(result).to match(/Last name[\n\r\s]+#{generated_name}/)

    # email
    expect(result).to include('Your email address')
    expect(result).to include('fb-acceptance-tests@digital.justice.gov.uk')

    # textarea
    expect(result).to include('Your cat')
    expect(result).to include('My cat is a fluffy killer named £ % ~ ! @ # $ ^ * ( ) - _ = + [ ] | ; , . ?')

    # checkbox
    expect(result).to include('Your fruit')
    expect(result).to include('Apples')
    expect(result).to include('Pears')

    # date
    expect(result).to include('When did your cat choose you?')
    expect(result).to include('12 November 2007')

    # number
    expect(result).to include('How many cats have chosen you?')
    expect(result).to include('28')
  end

  def find_attachments(id:)
    if ENV['CI_MODE'].present?
      EmailAttachmentExtractor.find(
        id: id,
        expected_emails: 1,
        find_criteria: :attachments
      )
    else
      {}
    end
  end
end
