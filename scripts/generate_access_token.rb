require "google/apis/gmail_v1"
require "googleauth"
require "googleauth/stores/file_token_store"
require "fileutils"
require "../integration/spec/support/email_output_service/google_service"

CREDENTIALS_PATH =  File.join(File.dirname(__FILE__), 'credentials.json').freeze
TOKEN_PATH = File.join(File.dirname(__FILE__), 'token.yaml').freeze
client_id = Google::Auth::ClientId.from_file(CREDENTIALS_PATH)
token_store = Google::Auth::Stores::FileTokenStore.new(file: TOKEN_PATH)
authorizer = Google::Auth::UserAuthorizer.new(client_id, GoogleService::SCOPE, token_store)

url = authorizer.get_authorization_url(base_url: GoogleService::OOB_URI)
puts "Open the following URL in the browser and enter the " \
      "resulting code after authorization:\n" + url
code = gets
authorizer.get_and_store_credentials_from_code(
  user_id: GoogleService::USER_ID,
  code: code,
  base_url: GoogleService::OOB_URI
)
puts "Saved access token to #{GoogleService::TOKEN_PATH}"

credentials = JSON.parse(File.read(CREDENTIALS_PATH))
token = JSON.parse(YAML.load_file(TOKEN_PATH)[GoogleService::USER_ID])

puts "Removing credentials"
File.delete(CREDENTIALS_PATH)

puts "Removing token"
File.delete(TOKEN_PATH)

puts "Set these in your local environment or in the CI environment"
puts "GOOGLE_PROJECT_ID=#{credentials['installed']['project_id']}"
puts "GOOGLE_CLIENT_ID=#{credentials['installed']['client_id']}"
puts "GOOGLE_CLIENT_SECRET=#{credentials['installed']['client_secret']}"
puts "GOOGLE_ACCESS_TOKEN=#{token['access_token']}"
puts "GOOGLE_REFRESH_TOKEN=#{token['refresh_token']}"
