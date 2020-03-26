require 'spec_helper'

class MaintenanceModeApp < SitePrism::Page
  set_url 'http://features-maintenance-mode-app:3000/{/url}'
end

class EmailApp < SitePrism::Page
  set_url 'http://features-email-app:3000'
end

describe 'Maintenance mode' do
  let(:maintenance_content) do
    'Sorry, the service is unavailable'
  end

  context 'when maintenance mode is on' do
    let(:form) { MaintenanceModeApp.new }

    it 'redirects root page to the maintenance page' do
      form.load

      expect(form.text).to include(maintenance_content)
    end

    it 'redirects any request to the maintenance page' do
      form.load(url: '/step1')

      expect(form.text).to include(maintenance_content)
    end
  end

  context 'when maintenance mode is off' do
    let(:form) { EmailApp.new }

    context 'when visiting any page' do
      it 'redirects any request to the maintenance page' do
        form.load

        expect(form.text).to_not include(maintenance_content)
      end
    end

    context 'when visiting the maintenance page' do
      it 'redirects any request to the maintenance page' do
        form.load('restricted/maintenance')

        expect(form.text).to_not include(maintenance_content)
      end
    end
  end
end
