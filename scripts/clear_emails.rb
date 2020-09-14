require './integration/spec/support/email_output_service/google_service'

USER_ID = 'me'.freeze

service = GoogleService.new.authenticated_service
emails = service.list_user_messages(USER_ID).messages
twenty_four_hours_ago = Time.now - (3600 * 24)

Array(emails).each do |email|
  message = service.get_user_message(USER_ID, email.id)

  begin
    subject = message.payload.headers.find { |h| h.name == 'Subject' }&.value
    received = message.payload.headers.find { |h| h.name == 'Received' }&.value
    time_received = Time.parse(/[^;]*$/.match(received)[0].strip)

    puts "Checking receipt time for #{subject}"
    if time_received <= twenty_four_hours_ago
      puts "Trashing email older than 24 hours => #{subject}"
      service.trash_user_message(USER_ID, email.id)
    end
  rescue TypeError
    puts "********************************************\n"
    puts "Unable to parse date for email => #{subject}\n"
    puts "********************************************\n"
    next
  end
end
