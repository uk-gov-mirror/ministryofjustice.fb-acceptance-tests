class MaintenanceModeApp < SitePrism::Page
  set_url "#{ENV.fetch('FEATURES_MAINTENANCE_MODE_APP')}/{/url}"
end
