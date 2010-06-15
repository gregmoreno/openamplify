require 'net/http'
require 'uri'
require 'json'

module OpenAmplify
  API_URL = "http://portaltnx20.openamplify.com/AmplifyWeb_v20/AmplifyThis"

  class Client
    def initialize(options={})
      @options = { :api_url => API_URL, :method => :get }
      @options.merge!(OpenAmplify.symbolize_keys(options))
    end

    def analyze_text(text)
      OpenAmplify.validate_client!(self)
      Response.new(self, :query => query.merge(:inputText => text), :method => @options[:method])
    end
    
    %w(api_key analysis api_url method).each do |attr|
      class_eval <<-EOS
        def #{attr}
          @options[:#{attr}]
        end

        def #{attr}=(v)
          @options[:#{attr}] = v 
        end
      EOS
    end
    
    def fetch(params, method)
      raise OpenAmplify::NotSupported unless [:get, :post].include?(method.to_sym)
      Client::send(method, self.api_url, params)
    end

    def self.compose_url(path, params)
      path + '?' + URI.escape(params.collect{ |k,v| "#{k}=#{v}" }.join('&'))
    end


    private


    def query
      q = { :apiKey => @options[:api_key] }
      q.merge!(:analysis => @options[:analysis]) if @options[:analysis]
      q
    end

    def self.get(path, params)
      uri      = URI.parse(compose_url(path, params))
      response = Net::HTTP.get_response(uri)
      OpenAmplify.validate_response!(response) 
      response.body
    end

    def self.post(path, params)
      uri      = URI::parse(path)
      response = Net::HTTP.post_form(uri, params)
      OpenAmplify.validate_response!(response)
      response.body
    end

  end # OpenAmplify::Client 


  # Contains the response from OpenAmplify
  class Response
    include Enumerable

    def initialize(client, options)
      @client  = client
      @options = options
    end

    def request_url
      @request_url ||= Client.compose_url(@client.api_url, @options[:query]) 
    end

    def reload
      response
    end
    
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
          fetch_as_format(:#{format})
        end
      EOS
    end

    def top_topics
      items = response && response['Topics']['TopTopics']
    end

    def proper_nouns
      items = response && response['Topics']['ProperNouns']

      return items if items.is_a?(Array)

      # I'm not sure if this is the default behavior if
      # only a single item is found, or if it is a bug
      # TODO: check other helpers as well
      if items.is_a?(Hash)
        return [ items['TopicResult'] ]
      end
    end

    def locations
      response && response['Topics']['Locations']
    end

    def domains
      response && response['Topics']['Domains']
    end

    def styles
      response && response['Styles']
    end

    private

    def response
      @response ||= fetch_response
    end
  
    def fetch_response
      response = fetch_as_format(:json)
      result   = JSON.parse(response)

      if analysis = @options[:query][:analysis]
        name = analysis.sub(/./){ |s| s.upcase }
        result["ns1:#{name}Response"]["#{name}Return"]
      else
        result['ns1:AmplifyResponse']['AmplifyReturn']
      end
    end

    def fetch_as_format(format)
      @client.fetch(@options[:query].merge(:outputFormat => format), @options[:method])
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

require 'openamplify/validations'
