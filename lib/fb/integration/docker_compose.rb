module Fb
  module Integration
    class DockerCompose
      include Command

      attr_reader :repository

      delegate :destination, to: :repository

      def initialize(repository:)
        @repository = repository
      end

      def execute
        run_command(command: "docker-compose up -d --build #{destination}-app")
      end
    end
  end
end
