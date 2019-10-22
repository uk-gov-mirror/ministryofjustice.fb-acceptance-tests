require 'sinatra'

class App < Sinatra::Base
  post '/persist-payload' do

    p '-------------'
    p params['attachments']
    p '-------------'

    'hi hi'
  end

  get '/hi' do
    'hi hi'
  end
end
