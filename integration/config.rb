# Maybe move this to a yaml file?
#
Fb::Integration.configure do |config|
  config.repositories = [
    { name: 'fb-submitter', destination: 'submitter' },
    { name: 'fb-user-filestore', destination: 'filestore' },
    { name: 'fb-user-datastore', destination: 'datastore' },
    { name: 'fb-pdf-generator', destination: 'pdf-generator' },
    { name: 'fb-service-token-cache', destination: 'service-token-cache' }
  ]

  config.form_repository = Fb::Integration::Repository.new(
    name: 'fb-runner-node',
    destination: 'runner'
  )
end
