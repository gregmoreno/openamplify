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

      def call
        self.analysis = self.client.request_analysis(request_analysis_options)
      end

      def request_analysis_options
        Hash[* Analysis::Configuration::VALID_OPTIONS_KEYS.map { |key| [key, send(key) ]}.flatten ]
        # TODO: Add rules here? like mutex source_url:input_text
      end

    end # Context

  end # Analysis

end
