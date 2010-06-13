module OpenAmplify

  class Client

    private

    def validate
      raise ArgumentError, "missing api key" if self.api_key.blank?
      raise ArgumentError, "missing api url" if self.api_url.blank?
    end
  end


  class NotAcceptable < StandardError; end
  class NotSupported  < StandardError; end
  class Forbidden     < StandardError; end


  class Response
    def self.validate(response)
      case response.code.to_i
        when 403
          raise Forbidden, "(#{response.code}: #{response.message}) #{response.body}"
        when 405
          raise NotSupported, "(#{response.code}: #{response.message}) #{response.body}"
        when 406
          raise NotAcceptable, "(#{response.code}: #{response.message}) #{response.body}" 
      end
    end
  end

end

class String
  def blank?
    nil? || empty? || strip.empty? 
  end
end

class NilClass
  def blank?
    nil?
  end
end

