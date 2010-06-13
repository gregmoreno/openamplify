module OpenAmplify

  class Client

    private

    def validate
      raise ArgumentError, "missing api key" if self.api_key.blank?
      raise ArgumentError, "missing api url" if self.api_url.blank?
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

