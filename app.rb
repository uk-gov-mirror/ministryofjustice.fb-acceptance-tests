require 'sinatra'

post '/persist-payload' do
  100.times do
    p 'Hello world!'
  end

  'hi hi'
end

get '/hi' do
  'hi hi'
end
