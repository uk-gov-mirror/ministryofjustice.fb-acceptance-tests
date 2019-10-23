require 'sinatra'

class App < Sinatra::Base
  post '/' do
    File.open('/tmp/result.json', 'w') { |file| file.write(params.to_json) }

    ''
  end

  get '/' do
    content_type :json

    begin
      File.read('/tmp/result.json')
    rescue
      status 404
    end
  end

  get '/health' do
    'healthy'
  end
end
