module Fb
  module Integration
    class DockerCompose
      include Command
      attr_reader :repositories

      def initialize(repositories)
        @repositories = repositories
      end

      def execute
        run_command(command: "docker-compose build --parallel #{containers}")
        update_containers
      end

      def update_containers
        run_command(command: "docker-compose up -d #{containers}")
      end

      def containers
        repositories.map do |repository|
          "#{repository.destination}-app"
        end.join(' ')
      end
    end
  end
end
