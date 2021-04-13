class NewRunnerApp < FeaturesEmailApp
  set_url ENV.fetch('NEW_RUNNER_APP')

  element :start_button, :button, 'Start now'
  element :yes_field, :radio_button, 'Yes', visible: false
  element :cookies_link, :link, 'Cookies'
  element :privacy_link, :link, 'Privacy'
  element :accessibility_link, :link, 'Accessibility'
end
