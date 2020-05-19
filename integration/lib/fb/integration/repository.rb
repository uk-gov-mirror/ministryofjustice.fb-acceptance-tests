module Fb
  module Integration
    class Repository
      ## Can be :local or :remote
      #
      attr_accessor :setup_type

      ## Name of the repository
      #
      attr_accessor :name

      ## Destination hidden folder that the repo will be after setup
      #
      attr_accessor :destination

      def initialize(name:, destination:, **options)
        @name = name
        @destination = destination
        @setup_type = options[:setup_type]
      end

      def github
        "git@github.com:ministryofjustice/#{name}.git"
      end
    end
  end
end
