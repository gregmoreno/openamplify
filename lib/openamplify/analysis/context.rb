require 'openamplify/analysis/configuration'

module OpenAmplify

  module  Analysis

    class Context
      attr_accessor *Analysis::Configuration::VALID_OPTIONS_KEYS
      attr_accessor :options, :client

      def initialize(client, options)
        self.client  = client
        self.options = options

        merged_options = Analysis::Configuration.options.merge(options)
        Analysis::Configuration::VALID_OPTIONS_KEYS.each do |key|
          send("#{key}=", merged_options[key])
        end
      end

    end

  end

end
