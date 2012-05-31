require 'openamplify/analysis/context'
require 'openamplify/connection'
require 'openamplify/request'

module OpenAmplify
  # Provides access to the OpenAmplify API http://portaltnx20.openamplify.com/AmplifyWeb_v20/
  #
  # Basic usage of the library is to call supported methods via the Client class.
  #
  #   text = "After getting the MX1000 laser mouse and the Z-5500 speakers i fell in love with logitech"
  #   OpenAmplify::Client.new.analyze_text(text)

  class Client
    include OpenAmplify::Connection
    include OpenAmplify::Request

    attr_accessor *Configuration::VALID_CONFIG_KEYS

    def initialize(options={})
      merged_options = OpenAmplify.options.merge(options)
      Configuration::VALID_CONFIG_KEYS.each do |key|
        send("#{key}=", merged_options[key])
      end
    end

    def amplify(input, options={})
      options = analysis_options.merge(options)
      Analysis::Context.new(self, input, options)
    end

    def analysis_options
      Hash[ *Configuration::VALID_OPTIONS_KEYS.map { |key| [key, send(key)] }.flatten ]
    end

    def request_analysis(options)
      params = prepare_request_params(options)

      case self.http_method
      when :post
        post(self.endpoint, params)
      else
        get(self.endpoint, params)
      end
    end

    # @deprecated Please use {#amplify} instead
    def analyze_text(input)
      warn "[DEPRECATION] `analyze_text` is deprecated.  Please use `amplify` instead."
      amplify input
    end

    # @deprecated Please use {#endpoint} instead
    def base_url=(url)
      warn "[DEPRECATION] `base_url` is deprecated.  Please use `endpoint` instead."
      self.endpoint = url
    end





    private

    # Formulate the parameters that is understood by
    # the OpenAmplify webservice.
    # ex: :api_key  becomes  'apikey'
    def prepare_request_params(options)
      params = detect_request_input options.delete(:input)

      options.inject(params) do |params, kv|
        key, value = kv
        params.merge!("#{key.to_s.downcase.gsub(/_+/, '')}" => value)
      end
    end

    def detect_request_input(input)
      if input =~ /^https?:\/\//
        { 'sourceurl' => input }
      else
        { 'inputtext' => input }
      end
    end

  end # Client

end
