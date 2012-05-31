require 'multi_json'
require 'openamplify/version'

# TODO: output_format, analysis, scoring can be specied in the client and becomes the default unless overriden

module OpenAmplify
  # Defines constants and methods for configuring a client
  module Configuration
    VALID_OPTIONS_KEYS = [:api_key, :endpoint, :user_agent, :http_method].freeze

    DEFAULT_API_KEY     = nil
    DEFAULT_ENDPOINT    = 'http://portaltnx20.openamplify.com/AmplifyWeb_v21/AmplifyThis'
    DEFAULT_HTTP_METHOD = :get

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
      self.api_key     = DEFAULT_API_KEY
      self.endpoint    = DEFAULT_ENDPOINT
      self.http_method = DEFAULT_HTTP_METHOD
      self.user_agent  = DEFAULT_USER_AGENT
    end

  end # Configuration

end
