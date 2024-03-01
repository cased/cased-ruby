# frozen_string_literal: true

require 'active_support/log_subscriber'

module Cased
  module Instrumentation
    class LogSubscriber < ActiveSupport::LogSubscriber
      def self.events=(value)
        Thread.current['cased_events'] = value
      end

      def self.events
        Thread.current['cased_events'] ||= 0
      end

      def self.reset_events
        self.events = 0
      end

      def audit_event(event)
        self.class.events += 1

        event = JSON.generate(event.payload[:event])
        name = color('Cased', CYAN, bold: true)
        debug "  #{name} #{event}"
      end

      attach_to :cased
    end
  end
end
