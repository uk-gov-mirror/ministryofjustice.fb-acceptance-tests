describe 'New Runner' do
  let(:form) { NewRunnerApp.new }
  before :each do
    OutputRecorder.cleanup_recorded_requests if ENV['CI_MODE'].blank?
  end
  let(:generated_first_name) { SecureRandom.uuid }

  it 'sends an email with the submission in a PDF' do
    form.load
    form.start_button.click
    form.first_name_field.set('Stormtrooper')
    form.last_name_field.set('FN-2187')
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

    click_on 'Accept and send application'

    expect(form.text).to include("You've sent us the answers about your cat!")

    attachments = find_attachments(
      id: 'Submission for New Acceptance tests Email Output',
      pdf_filename: '-answers.pdf',
      user_attachment_filename: 'hello_world.txt'
    )

    assert_pdf_contents(attachments[:pdf_answers])
  end

  def continue
    form.continue_button.click
  end

  def parse_email(email)
    url_decoded_hash = CGI::parse(email)
    Mail.read_from_string(url_decoded_hash.fetch('raw_message'))
  end

  def assert_pdf_contents(attachment)
    pdf_path = '/tmp/submission.pdf'

    File.open(pdf_path, 'w') { |file| file.write(attachment) }
    result = PDF::Reader.new(pdf_path).pages.map { |page| page.text }.join(' ')

    p 'Asserting PDF contents'

    expect(result).to include('Submission for New Acceptance tests Email Output')

    # text
    expect(result).to include('Your name')
    expect(result).to match(/First name[\n\r\s]+#{generated_first_name}/)
    expect(result).to match(/Last name[\n\r\s]+Builders/)

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

  def find_attachments(id:, pdf_filename:, user_attachment_filename:)
    if ENV['CI_MODE'].present?
      EmailAttachmentExtractor.find(
        id: id,
        pdf_filename: pdf_filename,
        user_attachment_filename: user_attachment_filename,
        expected_emails: 1
      )
    else
      all_attachments = {}

      emails = OutputRecorder.wait_for_result(url: '/email', expected_requests: 4)
      emails[0..1].each do |email|
        attachments = parse_email(email).attachments
        pdf_answers = attachments.detect do |attachment|
          attachment.filename.include?(pdf_filename)
        end
        file_upload = attachments.detect do |attachment|
          attachment.filename.include?(user_attachment_filename)
        end

        all_attachments[:pdf_answers] = pdf_answers.decoded
        all_attachments[:file_upload] = file_upload.decoded
      end

      all_attachments[:csvs] = emails[2..3].map do |email|
        parse_email(email).attachments.map(&:decoded)
      end.flatten

      all_attachments
    end
  end
end
