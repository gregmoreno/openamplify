module OpenAmplify

  module  Analysis

    class Context
      VALID_OPTIONS_KEYS = OpenAmplify::Configuration::VALID_OPTIONS_KEYS + [:input]

      attr_accessor *VALID_OPTIONS_KEYS

      attr_accessor :options, :client
      attr_reader   :result

      def initialize(client, input, options)
        self.client = client
        self.input  = input

        merged_options = OpenAmplify.options.merge(options)
        OpenAmplify::Configuration::VALID_OPTIONS_KEYS.each do |key|
          send("#{key}=", merged_options[key])
        end
      end

      # The empty?, to_s, to_str are to make our object play
      # with others that expect a string.
      #
      # Example, you can do this:
      #   puts result
      #
      # instead of:
      #   puts result.to_s

      def empty?
        result.empty?
      end

      def to_s
        "#{result}"
      end
      alias_method :to_str, :to_s

      # Support various conversion helpers

      %w(xml json json_js rdf rdfa csv signals pretty dart oas).each do |format|
        define_method("to_#{format}") do
          @result = call(:output_format => format)
        end
      end

      private

      def result
        @result ||= call
      end

      def call(options={})
        @result = client.request_analysis(request_analysis_options.merge(options))
      end

      def request_analysis_options
        options = Hash[* VALID_OPTIONS_KEYS.map { |key| [key, send(key) ]}.flatten ]
      end

    end # Context

  end # Analysis

end
