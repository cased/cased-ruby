# frozen_string_literal: true

require 'active_support/core_ext'

module Cased
  class Response
    attr_reader :body, :exception

    def initialize(response: nil, exception: nil)
      @response = response
      @body = response&.body
      @exception = exception
    end

    def error
      @exception.presence || (body && body['error']).presence
    end

    def error?
      # If there was an exception during the execution of the request.
      return true if @exception.present?

      # If the HTTP response was outside of 200-299
      return true unless @response.success?

      # If the HTTP response contained an error key.
      return true if body && body['error'].present?

      false
    end

    def success?
      return false if @response.nil?

      @response.success?
    end
  end
end
