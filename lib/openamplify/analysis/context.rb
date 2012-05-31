require 'openamplify/analysis/configuration'

module OpenAmplify

  module  Analysis

    class Context
      attr_accessor *Analysis::Configuration::VALID_OPTIONS_KEYS
      attr_accessor *Analysis::Configuration::VALID_INPUT_KEYS

      attr_accessor :options, :client
      attr_reader   :analysis

      def initialize(client, options)
        self.client  = client

        merged_options = Analysis::Configuration.options.merge(options)
        Analysis::Configuration::VALID_OPTIONS_KEYS.each do |key|
          send("#{key}=", merged_options[key])
        end

        Analysis::Configuration::VALID_INPUT_KEYS.each do |key|
          send("#{key}=", merged_options[key])
        end
      end

      def to_s
        call
      end

      def call
        self.analysis = self.client.request_analysis(request_analysis_options)
      end

      def request_analysis_options
        options = Hash[* Analysis::Configuration::VALID_OPTIONS_KEYS.map { |key| [key, send(key) ]}.flatten ]

        # TODO: Check for blank or empty string
        if self.input_text
          options.merge(:input_text => self.input_text)
        else
          options.merge(:source_url => self.source_url)
        end
      end

    end # Context

  end # Analysis

end
