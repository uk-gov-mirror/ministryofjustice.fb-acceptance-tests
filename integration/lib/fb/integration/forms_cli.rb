require 'optparse'

module Fb
  module Integration
    class FormsCLI
      include Command
      attr_reader :setup_type, :start, :stop, :status

      def initialize(args)
        @args = args
        @options = options
      end

      def run
        repository = Fb::Integration.form_repository

        if repository.blank?
          error_message = 'Repository "fb-runner" config not found. Compare config.rb.sample file with config.rb file.'
          raise error_message if repository.blank?
        end

        if setup_type.present?
          CleanupRepository.new(repository: repository).execute
          Fb::Integration::SetupRepository.new(
            repository: repository
          ).execute(setup_type: setup_type)
        end

        if status.present?
          run_status
        end

        if start.present?
          run_stop
          run_command(command: 'npm install')
          run_command(command: 'procodile start -f')
          run_status
        end

        if stop.present?
          run_stop
          run_status
        end
      end

      private

      def run_stop
        run_command(command: 'procodile stop --procfile Procfile')
      end

      def run_status
        run_command(
          command: "docker-compose exec services sh -c 'procodile status --procfile Procfile'"
        )
      end

      def options
        OptionParser.new do |option|
          option.on('--local', 'Copy fb-runner from local machine') do
            @setup_type = 'local'
          end

          option.on('--remote', 'Clone fb-runner from Github.') do
            @setup_type = 'remote'
          end

          option.on('--start', 'Start all forms') do
            @start = true
          end

          option.on('--stop', 'Stop all forms') do
            @stop = true
          end

          option.on('--status', 'Stop all forms') do
            @status = true
          end

          option.on_tail('--help', "You're looking at it.") do
            print option.help
            exit
          end
        end.parse!(@args)
      end
    end
  end
end
