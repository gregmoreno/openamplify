require 'faraday'
require 'openamplify/error'

module OpenAmplify
  module Response
    class RaiseServerError < Faraday::Response::Middleware

      def on_complete(env)
        status  = env[:status].to_i
        body    = env[:body]
        headers = env[:response_headers]

        case status
        when 503
          raise OpenAmplify::Error::ServiceUnavailable.new "503 No server is available to handle this request.", headers
        else
          raise OpenAmplify::Error.new "#{status}: Unsupported error. #{body}", headers
        end
      end

    end # RaiseServerError

  end # Response

end
