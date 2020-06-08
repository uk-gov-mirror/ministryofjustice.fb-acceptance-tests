require 'sinatra'
require 'json'
require 'sinatra/json'
require 'pry'
require 'jwe'

PAYLOAD_CONTENT_FILE = 'tmp/payload_content.json'

JSON_KEY='82fb39fa0446'

post "/submission" do
  payload = request.body.read
  File.write(PAYLOAD_CONTENT_FILE, payload)
end

get "/submission" do
  encrypted_payload = File.read(PAYLOAD_CONTENT_FILE)
  JSON.parse(JWE.decrypt(encrypted_payload, JSON_KEY), symbolize_names: true)
end
