# frozen_string_literal: true

require 'active_support/testing/assertions'

module Cased
  module Instrumentation
    class LogSubscriberTest < Cased::Test
      Event = Struct.new(:payload, keyword_init: false)

      def test_can_log_audit_event
        log_subscriber = Cased::Instrumentation::LogSubscriber.new
        log_subscriber.audit_event(Event.new(action: 'user.login'))
      end
    end
  end
end
