require 'openamplify/version'

# TODO: output_format, analysis, scoring can be specied in the client and becomes the default unless overriden

module OpenAmplify
  # Defines constants and methods for configuring a client
  module Configuration
    VALID_CONNECTION_KEYS = [:endpoint, :user_agent, :method, :adapter].freeze
    VALID_OPTIONS_KEYS    = [:api_key, :analysis, :output_format, :scoring].freeze

    VALID_CONFIG_KEYS     = VALID_CONNECTION_KEYS + VALID_OPTIONS_KEYS

    DEFAULT_ENDPOINT      = 'http://portaltnx20.openamplify.com/AmplifyWeb_v21/AmplifyThis'
    DEFAULT_HTTP_METHOD   = :get
    DEFAULT_HTTP_ADAPTER  = :net_http
    DEFAULT_USER_AGENT    = "OpenAmplify Ruby Gem #{OpenAmplify::VERSION}".freeze

    DEFAULT_API_KEY       = nil
    DEFAULT_ANALYSIS      = :all
    DEFAULT_OUTPUT_FORMAT = :xml
    DEFAULT_SCORING       = :standard
    DEFAULT_SOURCE_URL    = nil
    DEFAULT_INPUT_TEXT    = nil

    attr_accessor *VALID_CONFIG_KEYS

    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    def options
      Hash[ * VALID_CONFIG_KEYS.map { |key| [key, send(key)] }.flatten ]
    end

    def reset
      self.endpoint      = DEFAULT_ENDPOINT
      self.method        = DEFAULT_HTTP_METHOD
      self.adapter       = DEFAULT_HTTP_ADAPTER
      self.user_agent    = DEFAULT_USER_AGENT

      self.api_key       = DEFAULT_API_KEY
      self.analysis      = DEFAULT_ANALYSIS
      self.output_format = DEFAULT_OUTPUT_FORMAT
      self.scoring       = DEFAULT_SCORING
    end

  end # Configuration

end
