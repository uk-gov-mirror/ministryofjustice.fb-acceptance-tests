class NewRunnerApp < FeaturesEmailApp
  set_url ENV.fetch('NEW_RUNNER_APP')

  element :start_button, :button, 'Start now'
end
