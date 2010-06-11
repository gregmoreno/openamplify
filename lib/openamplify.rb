require 'net/http'
require 'uri'
require 'json'

module OpenAmplify
  API_URL = "http://portaltnx20.openamplify.com/AmplifyWeb_v20/AmplifyThis"

  class Client
    def initialize(options)
      @options = { :base_url => API_URL }
      @options.merge!(OpenAmplify.symbolize_keys(options))
    end

    def analyze_text(text)
      Response.new(:base_url => @options[:base_url], :query => query.merge(:inputText => text))
    end
    
    %w(api_key analysis base_url).each do |attr|
      class_eval <<-EOS
        def #{attr}
          @options[:#{attr}]
        end

        def #{attr}=(v)
          @options[:#{attr}] = v 
        end
      EOS
    end

    private

    def query
      q = { :apiKey => @options[:api_key] }
      q.merge!(:analysis => @options[:analysis]) if @options[:analysis]
      q
    end

  end # OpenAmplify::Client 

  # Contains the response from OpenAmplify
  class Response
    include Enumerable

    def initialize(options)
      @options = options
    end

    def request_url
      @request_url ||= compose_url(@options[:base_url], @options[:query]) 
    end
    
    # Make this class behave like a Hash
    def each
      response.each do |k, v|
        yield(k, v)
      end
    end

    def method_missing(name, *args, &block)
      response.send(name, *args, &block)
    end
     
    # Support the different formats. Note this would entail another request
    # to openamplify
    %w(xml json rdf csv oas signals pretty).each do |format|
      class_eval <<-EOS
        def to_#{format}
          get('#{format}')
        end
      EOS
    end

    def top_topics
      response && response['Topics']['TopTopics']
    end

    def proper_nouns
      response && response['Topics']['ProperNouns']
    end

    def locations
      response && response['Topics']['Locations']
    end

    def domains
      response && response['Topics']['Domains']
    end

    private

    def response
      @response ||= get_response
    end

    def compose_url(path, params)
      path + '?' + URI.escape(params.collect{ |k, v| "#{k}=#{v}" }.join('&'))
    end
  
    def get_response
      response = get('json') 
      result   = JSON.parse(response)
     
      if analysis = @options[:query][:analysis]
        name = analysis.sub(/./){ |s| s.upcase }
        result["ns1:#{name}Response"]["#{name}Return"]
      else
        result['ns1:AmplifyResponse']['AmplifyReturn']
      end
    end

    def get(format)
      params = @options[:query]
      url    = compose_url(@options[:base_url], params.merge(:outputFormat => format))
      Net::HTTP.get_response(URI.parse(url)).body
    end

  end # OpenAmplify::Response

  private 

  def self.symbolize_keys(hash)
    hash.inject({}) do |options, (key, value)|
      options[(key.to_sym rescue key) || key] = value
      options
    end
  end

end # module OpenAmplify
