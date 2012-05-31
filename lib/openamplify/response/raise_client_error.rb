require 'faraday'

module OpenAmplify

  module Response

    class RaiseClientError < Faraday::Response::Middleware

      def on_complete(env)
        status  = env[:status].to_i
        body    = env[:body]
        headers = env[:response_headers]

        case status
        when 400
          raise OpenAmplify::Error::BadRequest.new body, headers
        when 403
          raise OpenAmplify::Error::Forbidden.new body, headers
        when 413
          raise OpenAmplify::Error::RequestTooLarge.new body, headers
        end
      end

    end # RaiseClientError

  end # Response

end
