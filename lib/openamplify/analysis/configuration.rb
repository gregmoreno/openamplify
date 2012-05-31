module OpenAmplify

  module Analysis

    module Configuration
      VALID_OPTIONS_KEYS = [:analysis, :output_format, :scoring].freeze
      VALID_INPUT_KEYS   = [:source_url, :input_text].freeze

      class << self
        attr_accessor *VALID_OPTIONS_KEYS
        attr_accessor *VALID_INPUT_KEYS
      end

      DEFAULT_ANALYSIS      = :all
      DEFAULT_OUTPUT_FORMAT = :xml
      DEFAULT_SCORING       = :standard
      DEFAULT_SOURCE_URL    = nil
      DEFAULT_INPUT_TEXT    = nil

      def self.extended(base)
        base.reset
      end

      def self.options
        reset
        Hash[ * VALID_OPTIONS_KEYS.map { |key| [key, send(key)] }.flatten ]
      end

      def self.reset
        self.analysis      = DEFAULT_ANALYSIS
        self.output_format = DEFAULT_OUTPUT_FORMAT
        self.scoring       = DEFAULT_SCORING
        self.source_url    = DEFAULT_SOURCE_URL
        self.input_text    = DEFAULT_INPUT_TEXT
      end

    end # Analysis

  end

end