require 'sinatra'

class App < Sinatra::Base
  post '/' do
    File.open('/tmp/result.json', 'w') { |file| file.write(params.to_json) }

    status 201
  end

  get '/' do
    content_type :json

    begin
      File.read('/tmp/result.json')
    rescue
      status 404
    end
  end

  post '/json-output' do
    File.open('/tmp/json_result', 'w') { |file| file.write(request.body.read) }

    status 201
  end

  get '/json-output' do
    begin
      File.read('/tmp/json_result')
    rescue
      status 404
    end
  end

  get '/health' do
    'healthy'
  end
end
