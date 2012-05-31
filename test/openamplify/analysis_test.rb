require 'helper'

describe OpenAmplify::Analysis do
  before do
    @api = OpenAmplify::Client.new
  end

  it 'should output' do
    result = @api.amplify_this(:input_text => 'this is a test', :http_method => :post)
    result.to_s
  end

  it 'should have default values' do
    result = @api.amplify_this({})

    OpenAmplify::Analysis::Configuration::VALID_OPTIONS_KEYS.each do |key|
      result.send(key).must_equal OpenAmplify::Analysis::Configuration.options[key]
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
      :scoring       => :standard,
    }

    api    = OpenAmplify::Client.new(options)
    result = api.amplify_this(:input_text    => 'sample text')

    options.each do |key, value|
      result.send(key).must_equal options[key]
    end
  end

  # TODO: empty input_text, present both input_string and source_uri
end
