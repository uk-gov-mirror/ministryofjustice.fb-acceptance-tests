require_relative 'google_service'

class EmailFinder
  USER_ID = 'me'.freeze

  attr_reader :id

  def initialize(service:, id:, pdf_filename:, user_attachment_filename:)
    @service = service.new.authenticated_service
    @id = id
    @pdf_filename = pdf_filename
    @user_attachment_filename = user_attachment_filename
  end

  def email_received?
    emails.size == 2
  end

  def emails
    Array(messages).map do |m|
      message = service.get_user_message(USER_ID, m.id)
      subject = Array(message.payload.headers).find { |h| h.name == 'Subject' }&.value

      puts "Looking for subject with #{id} in #{subject}"
      message if subject.include?(id)
    end.compact
  end

  def attachments
    all_attachments = { csvs: [] }

    emails.map do |email|
      email.payload.parts.each do |part|
        next if part.filename.empty?

        data = part.body.data
        if data.blank?
          data = service.get_user_message_attachment(
            USER_ID,
            email.id,
            part.body.attachment_id
          ).data
        end

        if part.filename.include?(pdf_filename)
          all_attachments[:pdf_answers] = data
        elsif part.filename.include?(user_attachment_filename)
          all_attachments[:file_upload] = data
        elsif part.filename.include?('.csv')
          all_attachments[:csvs] << data
        end
      end
      puts "Trashing email #{email.id}"
      service.trash_user_message(USER_ID, email.id)
    end

    all_attachments
  end

  private

  def messages
    service.list_user_messages(USER_ID).messages
  end

  attr_reader :service, :pdf_filename, :user_attachment_filename
end
