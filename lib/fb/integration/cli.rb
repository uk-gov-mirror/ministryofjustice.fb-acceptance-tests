module Fb
  module Integration
    class CLI
      attr_accessor :options

      def initialize(args)
        @options = Options.new(args).parse
      end

      def run
        if @options.setup_repositories.present?
          setup_repositories if @options.install?
          build_containers
          post_install if @options.install?
        end
      end

      private

      def setup_repositories
        @options.setup_repositories.each do |setup_repository|
          repository = Fb::Integration.find_repository(setup_repository[:name])
          setup_type = setup_repository[:type] || repository.setup_type

          CleanupRepository.new(repository: repository).execute
          SetupRepository.new(
            repository: repository
          ).execute(setup_type: setup_type)
        end
      end

      def build_containers
        @options.setup_repositories.each do |setup_repository|
          repository = Fb::Integration.find_repository(setup_repository[:name])

          DockerCompose.new(repository: repository).execute
        end
      end

      def post_install
        SpecificPostInstall.new.execute
      end
    end
  end
end
