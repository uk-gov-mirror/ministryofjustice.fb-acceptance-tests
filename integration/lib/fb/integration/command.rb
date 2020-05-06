module Fb
  module Integration
    module Command
      def run_command(command:)
        puts "=" * 80
        puts "#{command}"
        system(command)
        puts "=" * 80
      end
    end
  end
end
