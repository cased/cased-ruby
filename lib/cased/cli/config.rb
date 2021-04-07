# frozen_string_literal: true

module Cased
  module CLI
    class Config
      # @example
      #   Cased.configure do |config|
      #     config.cli.metadata = {
      #       heroku_application: ENV['HEROKU_APP_NAME'],
      #       git_commit: ENV['HEROKU_SLUG_COMMIT'],
      #     }
      #   end
      attr_accessor :metadata

      def initialize
        @metadata = {}
      end
    end
  end
end
