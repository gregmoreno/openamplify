module OpenAmplify

  class Error < StandardError
    attr_reader :http_headers

    def initialize(message, http_headers)
      @http_headers = http_headers
      super(message)
    end

  end # Error

  class Error::ServerError        < OpenAmplify::Error; end
  class Error::ServiceUnavailable < Error::ServerError; end

  class Error::ClientError     < OpenAmplify::Error; end
  class Error::Forbidden       < Error::ClientError; end
  class Error::BadRequest      < Error::ClientError; end
  class Error::RequestTooLarge < Error::ClientError; end
end
