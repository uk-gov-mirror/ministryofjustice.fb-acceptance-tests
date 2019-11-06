require 'sinatra'

class App < Sinatra::Base
  EMAIL_RESULT_FILE = '/tmp/email.json'
  JSON_RESULT_FILE = '/tmp/json'

  post '/email' do
    File.open(EMAIL_RESULT_FILE, 'w') { |file| file.write(params.to_json) }

    status 201
  end

  get '/email' do
    content_type :json

    begin
      File.read(EMAIL_RESULT_FILE)
    rescue
      status 404
    end
  end

  post '/json' do
    File.open(JSON_RESULT_FILE, 'w') { |file| file.write(request.body.read) }

    status 201
  end

  get '/json' do
    begin
      File.read(JSON_RESULT_FILE)
    rescue
      status 404
    end
  end

  get '/health' do
    'healthy'
  end
end
