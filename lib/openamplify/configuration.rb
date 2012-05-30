require 'multi_json'
require 'openamplify/version'

module OpenAmplify
  # Defines constants and methods for configuring a client
  module Configuration
    VALID_OPTIONS_KEYS = [:consumer_key, :endpoint, :user_agent, :http_method, :parser].freeze

    DEFAULT_CONSUMER_KEY  = nil
    DEFAULT_ENDPOINT      = '/http://portaltnx20.openamplify.com/AmplifyWeb_v20'
    DEFAULT_HTTP_METHOD   = :post

    # The user agent that will be sent to the API endpoint if none is set
    DEFAULT_USER_AGENT = "OpenAmplify Ruby Gem #{OpenAmplify::VERSION}".freeze

    attr_accessor *VALID_OPTIONS_KEYS

    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    def options
      Hash[ * VALID_OPTIONS_KEYS.map { |key| [key, send(key)] }.flatten ]
    end

    def reset
      self.consumer_key = DEFAULT_CONSUMER_KEY
      self.endpoint     = DEFAULT_ENDPOINT
      self.http_method  = DEFAULT_HTTP_METHOD
      self.user_agent   = DEFAULT_USER_AGENT
    end

  end # Configuration

end
