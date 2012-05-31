require 'net/http'
require 'uri'

module OpenAmplify
  # Handless HTTP requests
  module Request

    def get(path, params={})
      ap params
      uri      = URI.parse compose_url(path, params)
      response = Net::HTTP.get_response uri

      ap compose_url(path, params)
      # TODO: handle exception
      response.body
    end

    def post(path, params={})
      uri      = URI.parse path
      response = Net::HTTP.post_form uri, params
      response.body
    end

    private

    def compose_url(path, params={})
      path + '?' + URI.escape(params.collect{ |k,v| "#{k}=#{v}" }.join('&'))
    end


  end # Request

end
