require "google/apis/gmail_v1"
require "googleauth"
require "googleauth/stores/file_token_store"
require "fileutils"

class GoogleService
  USER_ID = 'me'.freeze
  OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'.freeze
  APPLICATION_NAME = 'FB Acceptance Tests'.freeze
  CREDENTIALS_PATH =  File.join(File.dirname(__FILE__), 'credentials.json').freeze
  TOKEN_PATH = File.join(File.dirname(__FILE__), 'token.yaml').freeze
  SCOPE = Google::Apis::GmailV1::AUTH_GMAIL_MODIFY

  def authenticated_service
    service = Google::Apis::GmailV1::GmailService.new
    service.client_options.application_name = APPLICATION_NAME
    service.authorization = authorize
    service
  end

  def authorize
    File.write(CREDENTIALS_PATH, creds)
    client_id = Google::Auth::ClientId.from_file(CREDENTIALS_PATH)
    File.delete(CREDENTIALS_PATH)

    File.write(TOKEN_PATH, %Q(---\n#{USER_ID}: '#{token}'))
    authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
    credentials = authorizer.get_credentials(USER_ID, SCOPE)
    File.delete(TOKEN_PATH)

    credentials
  end

  def creds
    {
      installed: {
        client_id: ENV['GOOGLE_CLIENT_ID'],
        project_id: ENV['GOOGLE_PROJECT_ID'],
        auth_uri: 'https://accounts.google.com/o/oauth2/auth',
        token_uri: 'https://oauth2.googleapis.com/token',
        auth_provider_x509_cert_url: 'https://www.googleapis.com/oauth2/v1/certs',
        client_secret: ENV['GOOGLE_CLIENT_SECRET'],
        redirect_uris: [
          'urn:ietf:wg:oauth:2.0:oob',
          'http://localhost'
        ]
      }
    }.to_json
  end

  def token
    {
      client_id: ENV['GOOGLE_CLIENT_ID'],
      access_token: ENV['GOOGLE_ACCESS_TOKEN'],
      refresh_token: ENV['GOOGLE_REFRESH_TOKEN'],
      scope: [SCOPE],
      expiration_time_millis: 1597360311000
    }.to_json
  end

  def token_store
    Google::Auth::Stores::FileTokenStore.new(file: TOKEN_PATH)
  end
end
