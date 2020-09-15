require 'spec_helper'

class SmokeTestForm < ServiceApp
  set_url ENV.fetch('SMOKE_TEST_FORM')
end

describe 'Smoke test' do
  let(:form) { SmokeTestForm.new }
  let(:username) { ENV.fetch('SMOKE_TEST_USER') }
  let(:password) { ENV.fetch('SMOKE_TEST_PASSWORD') }

  before { form.load }

  it 'pass' do
    puts username
    puts password
    page.driver.basic_authorize(username, password)
    puts page.text
  end
end
