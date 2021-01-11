require 'active_support/all'

module Fb
  module Integration
    autoload :CLI, 'fb/integration/cli'
    autoload :CleanupRepository, 'fb/integration/cleanup_repository'
    autoload :Command, 'fb/integration/command'
    autoload :DockerCompose, 'fb/integration/docker_compose'
    autoload :FormsCLI, 'fb/integration/forms_cli'
    autoload :LoadConfig, 'fb/integration/load_config'
    autoload :Options, 'fb/integration/options'
    autoload :Repository, 'fb/integration/repository'
    autoload :SetupRepository, 'fb/integration/setup_repository'
    autoload :SpecificPostInstall, 'fb/integration/specific_post_install'
    autoload :TestsCLI, 'fb/integration/tests_cli'

    mattr_accessor :repositories
    @@repositories = []

    mattr_accessor :form_repository

    def self.configure
      yield self
    end

    def self.repositories=(repos)
      @@repositories = repos.map do |repo|
        Fb::Integration::Repository.new(**repo)
      end
    end

    def self.find_repository(name)
      repositories.find do |repository|
        repository.name == name || repository.destination == name
      end
    end
  end
end
