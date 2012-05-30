require 'openamplify/analysis/context'

module OpenAmplify
  # Provides access to the OpenAmplify API http://portaltnx20.openamplify.com/AmplifyWeb_v20/
  #
  # Basic usage of the library is to call supported methods via the Client class.
  #
  #   text = "After getting the MX1000 laser mouse and the Z-5500 speakers i fell in love with logitech"
  #   OpenAmplify::Client.new.analyze_text(text)

  # TODO: can it do this OpenAmplify::Client.analyze(text) ? after configuring it

  class Client
    attr_accessor *Configuration::VALID_OPTIONS_KEYS
    attr_accessor :options

    def initialize(options={})
      self.options  = options

      merged_options = OpenAmplify.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", merged_options[key])
      end
    end

    def amplify_this(options)
      Analysis::Context.new(self, options)
    end

  end # Client

end
