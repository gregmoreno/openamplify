require 'helper'

describe OpenAmplify::Analysis do

  before do
    @api = OpenAmplify::Client.new
  end

  it 'can return result as string' do
    result = @api.amplify amplify_input
    result.to_s.wont_be_empty
  end

  describe 'output format' do
    it 'xml' do
      result = @api.amplify(amplify_input, :output_format => :xml)

      require 'nokogiri'
      Nokogiri::XML(result).wont_be_nil
    end

    it 'json' do
      result = @api.amplify(amplify_input, :output_format => :json)

      require 'json'
      JSON.parse(result).wont_be_nil
    end

    %w(xml json json_js rdf rdfa csv signals pretty dart oas).each do |format|
      it "should output #{format}" do
        result = @api.amplify amplify_input
        result.send("to_#{format}").wont_be_nil
      end
    end

  end

  describe 'input analysis' do
    it 'knows a text' do
      result = @api.amplify amplify_input
      result.to_s.wont_be_empty
    end

    it 'knows a url' do
      result = @api.amplify 'http://theonion.com'

      require 'json'
      JSON.parse(result.to_json).wont_be_nil
    end
  end

  it 'should have default values' do
    result = @api.amplify amplify_input

    OpenAmplify::Configuration::VALID_OPTIONS_KEYS.each do |key|
      result.send(key).must_equal OpenAmplify.options[key]
    end
  end

  it 'should accept option values' do
    options = {
      :analysis      => :topics,
      :output_format => :json,
      :scoring       => :standard,
    }

    result = @api.amplify amplify_input, options

    options.each do |key, value|
      result.send(key).must_equal options[key]
    end
  end

  it 'should point the client' do
    result = @api.amplify amplify_input
    result.client.must_equal @api
  end

  it 'should accept option from client' do
    options = {
      :analysis      => :topics,
      :output_format => :json,
      :scoring       => :fans,
    }

    api = OpenAmplify::Client.new(options)
    result = api.amplify amplify_input

    options.each do |key, value|
      result.send(key).must_equal options[key]
    end
  end

  describe 'deprecated methods' do

    it 'analyze_text' do
      @api.analyze_text amplify_input
    end

  end

end
