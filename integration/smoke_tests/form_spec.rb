require 'spec_helper'

class SmokeTestForm < ServiceApp
  set_url ENV.fetch('SMOKE_TEST_FORM')
end

describe 'Smoke tests' do
  let(:form) { SmokeTestForm.new }

  before { form.load }

  it 'pass' do
  end
end
