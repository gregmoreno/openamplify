require 'faraday'
require 'openamplify/response/raise_client_error'
require 'openamplify/response/raise_server_error'

module OpenAmplify
  module Connection

    private

    def connection(options)
      default_options = {
        :url => options.fetch(:endpoint, endpoint)
      }

      @connection ||= Faraday.new(default_options) do |builder|
        builder.use OpenAmplify::Response::RaiseClientError
        builder.use OpenAmplify::Response::RaiseServerError

        # TODO: Make logging optional
        # builder.response :logger

        builder.adapter adapter
      end
    end

  end # Connection

end
