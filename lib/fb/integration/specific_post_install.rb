module Fb
  module Integration
    class SpecificPostInstall
      include Command

      def execute
        script = File.expand_path(
          File.join(
            File.dirname(__FILE__), '..', '..', '..', 'bin', 'post_install'
          )
        )

        run_command(command: script)
      end
    end
  end
end
