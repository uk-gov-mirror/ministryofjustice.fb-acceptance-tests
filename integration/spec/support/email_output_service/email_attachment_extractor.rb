class EmailAttachmentExtractor
  def self.find(id:, pdf_filename:, user_attachment_filename:)
    email_finder = EmailFinder.new(
      service: GoogleService,
      id: id,
      pdf_filename: pdf_filename,
      user_attachment_filename: user_attachment_filename
    )

    tries = 1
    max_tries = 20

    until tries > max_tries
      if email_finder.email_received?
        break
      else
        puts "Waiting for email #{tries} of #{max_tries}"
        sleep 5
        tries += 1
      end
    end

    if tries == max_tries || !email_finder.email_received?
      raise "Email '#{email_finder.id}' not found"
    else
      email_finder.attachments
    end
  end
end
