require 'sinatra'
require 'mail'

class App < Sinatra::Base
  post '/persist-payload' do
    File.open('/tmp/result.json', 'w') do |file|
      p 'we are writing to the file!'
      10.times do
        p 'printing jsonnnn'
        p params.to_json
      end
      file.write(params.to_json)
    end

    p 'this is us'
    p File.read('/tmp/result.json')

    # p '-------------'
    # p result = params['raw_message']
    # p mail = Mail.read_from_string(result)
    # p mail.attachments
    # p '-------------'

    'hi hi'
  end

  get '/payload' do
    content_type :json

    begin
      File.read('/tmp/result.json')
    rescue
      status 404
    end
  end
end
