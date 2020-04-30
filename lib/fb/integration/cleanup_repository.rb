module Fb
  module Integration
    class CleanupRepository
      include Command

      attr_reader :repository

      delegate :destination, to: :repository

      def initialize(repository:)
        @repository = repository
      end

      def execute
        command = "rm -rf .#{destination}"
        run_command(command: command)
      end
    end
  end
end
