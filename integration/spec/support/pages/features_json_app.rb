class FeaturesJSONApp < FeaturesEmailApp
  set_url ENV.fetch('FEATURES_JSON_APP')
end
