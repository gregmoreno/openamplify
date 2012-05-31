require 'net/http'
require 'uri'

module OpenAmplify
  # Handless HTTP requests
  module Request
    def get(path, params={}, options={})
      request(:get, path, params, options)
    end

    def post(path, params={}, options={})
      request(:post, path, params, options)
    end

    private

    def request(method, path, params, options)
      response = connection(options).run_request(method, nil, nil, nil) do |request|
        request.options[:raw] = true if options[:raw]

        case method.to_sym
        when :get 
          request.url(path, params)
        when :post
          request.path = path
          request.body = params unless params.empty?
        end
      end

      options[:raw] ? response : response.body
    end

  end # Request

end
