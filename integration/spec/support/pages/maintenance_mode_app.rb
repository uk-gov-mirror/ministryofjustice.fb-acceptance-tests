class MaintenanceModeApp < ServiceApp
  set_url "#{ENV.fetch('FEATURES_MAINTENANCE_MODE_APP')}/{/url}"
end
