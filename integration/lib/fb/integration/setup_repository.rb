module Fb
  module Integration
    class SetupRepository
      include Command
      attr_reader :repository

      delegate :name, :destination, :github, to: :repository

      def initialize(repository:)
        @repository = repository
      end

      def execute(setup_type:)
        raise "Setup type required for the repo: #{name}" if setup_type.blank?

        if setup_type == 'local'
          run_command(
            command: "ln -s ../#{name} .#{destination}"
          )
        elsif setup_type == 'remote'
          run_command(
            command: "git clone #{github} .#{destination}"
          )
        else
          raise "Setup type unknown for: #{name}"
        end
      end
    end
  end
end
