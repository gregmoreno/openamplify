require 'helper'

describe OpenAmplify::Analysis do

  before do
    @api = OpenAmplify::Client.new
  end

  it 'can return result as string' do
    result = @api.amplify_this(amplify_params)
    result.wont_be_nil
  end

  describe 'output format' do
    it 'xml' do
      result = @api.amplify_this(amplify_params.merge(:output_format => :xml))

      require 'nokogiri'
      Nokogiri::XML(result).wont_be_nil
    end

    it 'json' do
      result = @api.amplify_this(amplify_params.merge(:output_format => :json))

      require 'json'
      JSON.parse(result).wont_be_nil
    end

    %w(xml json json_js rdf rdfa csv signals pretty dart oas).each do |format|
      it "should output #{format}" do
        result = @api.amplify_this amplify_params
        result.send("to_#{format}").wont_be_nil
      end
    end

  end

  it 'can analyze text' do
    result = @api.analyze_text(amplify_params[:input_text])
    result.wont_be_nil
  end

  it 'can analyze a website' do
    result = @api.analyze_url('http://gregmoreno.ca') # or amplify_this(:source_url => 'http://path/')
    result.wont_be_nil
  end

  it 'should have default values' do
    result = @api.amplify_this({})

    OpenAmplify::Configuration::VALID_OPTIONS_KEYS.each do |key|
      result.send(key).must_equal OpenAmplify.options[key]
    end
  end

  it "should accept option values" do
    options = {
      :analysis      => :topics,
      :output_format => :json,
      :scoring       => :standard,
      :input_text    => 'sample text',
    }

    result = @api.amplify_this(options)

    options.each do |key, value|
      result.send(key).must_equal options[key]
    end
  end

  it 'should point the client' do
    result = @api.amplify_this({})
    result.client.must_equal @api
  end

  it "should accept option from client" do
    options = {
      :analysis      => :topics,
      :output_format => :json,
      :scoring       => :fans,
    }

    api = OpenAmplify::Client.new(options)
    result = api.amplify_this(:input_text => 'sample text')

    options.each do |key, value|
      result.send(key).must_equal options[key]
    end
  end

  # TODO: empty input_text, present both input_string and source_uri
end
