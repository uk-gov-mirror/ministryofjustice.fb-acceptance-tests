class EmailAttachmentExtractor
  def self.find(
    id:,
    expected_emails: nil,
    find_criteria: nil
  )
    tries = 1
    max_tries = 20

    until tries > max_tries
      email_finder = EmailFinder.new(id: id, service: GoogleService)
      email_finder.expected_emails = expected_emails if expected_emails.present?
      email_finder.find_criteria = find_criteria if find_criteria.present?

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
      email_finder.attachments.tap do
        email_finder.remove_emails
      end
    end
  end
end
