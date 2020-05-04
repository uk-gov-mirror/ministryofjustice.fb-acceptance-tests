require 'capybara/rspec'
require 'selenium/webdriver'
require 'site_prism'
require 'fb/integration'
require 'dotenv'
Dotenv.load('tests.env')

RSpec.configure do |c|
  Capybara.register_driver :selenium do |app|
    chrome_options = Selenium::WebDriver::Chrome::Options.new.tap do |o|
      o.add_argument '--headless'
      o.add_argument '--no-sandbox'
    end
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: chrome_options)
  end
  Capybara.default_driver = :selenium

  Capybara.app_host = 'http://localhost:3003'
  c.include Capybara::DSL

  Dir[
    File.expand_path(File.join(File.dirname(__FILE__), 'support', '**', '*.rb'))
  ].each { |f| require f }
end
