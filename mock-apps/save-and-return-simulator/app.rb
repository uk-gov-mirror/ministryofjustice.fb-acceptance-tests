require 'sinatra'
require 'json'
require 'sinatra/json'
require 'pry'

post '/email' do
  data = request.body.read
  parsed_data = JSON.generate(JSON.parse(data))
  if File.write('tmp/params.json', parsed_data)
    status 200
    body "Ok"
  else
    status 400
    body "Unable to generate params"
  end
end

get '/email' do
  json JSON.parse(File.read('tmp/params.json'))
end
