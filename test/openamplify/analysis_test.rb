require 'helper'

require 'awesome_print'

describe OpenAmplify::Analysis do
  before do
    @api = OpenAmplify::Client.new
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

  it 'should call the service' do
    result = @api.amplify_this(:input_text => 'sample text')
    ap result.call
  end


end
