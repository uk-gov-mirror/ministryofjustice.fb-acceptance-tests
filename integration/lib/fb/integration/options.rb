require 'optparse'

module Fb
  module Integration
    class Options
      attr_accessor :args, :install, :setup_repositories, :verbose, :no_build

      def initialize(*args)
        @args = args.flatten.clone
        @setup_repositories = []
      end

      def install?
        @install.present?
      end

      def no_build?
        @no_build.present?
      end

      def parse
        option_parser.parse!(args)

        self
      end

      private

      def option_parser
        OptionParser.new do |option|
					option.on('--install') do
            @install = true
          end

          Fb::Integration.repositories.each do |repository|
            custom_option = "--#{repository.destination}"
            option.on(
              custom_option,
              "Build/Update container"
            ) do
              setup_repository = @setup_repositories.find do |setup_repository|
                setup_repository[:name] == repository.name
              end

              if setup_repository.blank?
                @setup_repositories << { name: repository.name, type: 'remote' }
              end
            end

            option.on(
              "#{custom_option}-local",
              "Build container from local machine"
            ) do |type|
              @install = true

              add_local_repository(repository)
            end
          end

          option.on(
            '--update [REPOSITORY_NAME]',
            'Only rebuild/re-run the container'
          ) do |repository_name|
            repository = Fb::Integration.find_repository(repository_name)

            if repository
              @install = false
              add_local_repository(repository)
            else
              repositories = Fb::Integration.repositories.map(&:name)
              puts "Repository '#{repository_name}'. Available repositories: #{repositories}"
            end
          end

          option.on('--all') do
            Fb::Integration.repositories.each do |repository|
              @install = true
              @setup_repositories << { name: repository.name, type: 'remote' }
            end
          end

          option.on('--no-build') do
            @no_build = true
          end

          option.on('-v') do
            option.verbose = true
          end

					option.on_tail('--help', "You're looking at it.") do
          	print option.help
          	exit
        	end
        end
      end

      def add_local_repository(repository)
        setup_repository = @setup_repositories.find do |setup_repository|
          setup_repository[:name] == repository.name
        end

        if setup_repository.blank?
          @setup_repositories << { name: repository.name, type: 'local' }
        else
          setup_repository[:type] = 'local'
        end
      end
    end
  end
end
