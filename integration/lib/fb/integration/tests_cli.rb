require 'ostruct'

module Fb
  module Integration
    class TestsCLI
      include Command
      attr_reader :options

      def initialize(args)
        @options = OpenStruct.new(args: args)
      end

      def run
        parse_options.parse!(@options.args)

        if options.setup.present?
          run_command(command: 'bundle install')
          run_command(command: './bin/platform --install --all')

          if options.local.present?
            run_command(command: './bin/runner --local')
          else
            run_command(command: './bin/runner --remote')
          end

          run_command(command: './bin/runner --start')
        end

        if options.run.present?
          run_command(command: 'rspec spec')
        end
      end

      private

      def parse_options
        OptionParser.new do |option_parser|
          option_parser.on('--run', 'Run the tests without setup! If you want to setup the whole platform pass the --setup option') do
            @options.run = true
          end

          option_parser.on('--setup', 'Setup the whole platform.') do
            @options.setup = true
          end

          option_parser.on('--local', 'Setup the whole platform.') do
            @options.local = true
          end

          option_parser.on_tail('--help', "You're looking at it.") do
            puts option_parser.help
            exit
          end
        end
      end
    end
  end
end
