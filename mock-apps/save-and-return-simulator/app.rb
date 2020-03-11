require 'sinatra'
require 'json'
require 'sinatra/json'
require 'pry'

EMAIL_CONTENT_FILE = 'tmp/email_content.json'

post '/email' do
  data = request.body.read
  parsed_data = JSON.generate(JSON.parse(data))
  if File.write(EMAIL_CONTENT_FILE, parsed_data)
    status :ok
    body "Ok"
  else
    status :bad_request
    body "Unable to generate params"
  end
end

get '/email' do
  begin
    email_content = File.read(EMAIL_CONTENT_FILE)
    json JSON.parse(email_content)
  rescue
    status :not_found
  end
end
