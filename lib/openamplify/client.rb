require 'openamplify/analysis/context'
require 'openamplify/request'

module OpenAmplify
  # Provides access to the OpenAmplify API http://portaltnx20.openamplify.com/AmplifyWeb_v20/
  #
  # Basic usage of the library is to call supported methods via the Client class.
  #
  #   text = "After getting the MX1000 laser mouse and the Z-5500 speakers i fell in love with logitech"
  #   OpenAmplify::Client.new.analyze_text(text)

  # TODO: can it do this OpenAmplify::Client.analyze(text) ? after configuring it

  class Client
    include OpenAmplify::Request

    attr_accessor *Configuration::VALID_OPTIONS_KEYS
    attr_accessor *Analysis::Configuration::VALID_OPTIONS_KEYS

    attr_accessor :options

    def initialize(options={})
      merged_options = OpenAmplify.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", merged_options[key])
      end

      merged_options = Analysis::Configuration.options.merge(merged_options)
      Analysis::Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", merged_options[key])
      end
    end

    def amplify_this(options)
      options = analysis_options.merge(options)
      Analysis::Context.new(self, options)
    end

    def analysis_options
      Hash[ *Analysis::Configuration::VALID_OPTIONS_KEYS.map { |key| [key, send(key)] }.flatten ]
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

    private

    # Formulate the parameters that is understood by
    # the OpenAmplify webservice.
    def prepare_request_params(options)
      params = {
        'apiKey' => self.api_key,
      }

      options.inject(params) do |params, kv|
        key, value = kv
        params.merge!("#{key.to_s.downcase.gsub(/_+/, '')}" => value)
      end
    end

  end # Client

end
