class ComponentsUploadApp < ServiceApp
  set_url ENV.fetch('COMPONENTS_UPLOAD_APP')

  element :upload_description, 'li.govuk-body-l'
end
