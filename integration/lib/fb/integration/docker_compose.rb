module Fb
  module Integration
    class DockerCompose
      include Command
      attr_reader :repositories

      def initialize(repositories)
        @repositories = repositories
      end

      def execute
        containers = repositories.map do |repository|
          "#{repository.destination}-app"
        end.join(' ')
        run_command(command: "docker-compose build --parallel #{containers}")
        run_command(command: "docker-compose up -d #{containers}")
      end
    end
  end
end
