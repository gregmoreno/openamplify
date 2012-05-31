require 'helper'

describe OpenAmplify::Client do

  before do
    @api = OpenAmplify::Client.new
    @input_text = '' # TODO: Load a fixture
  end

  it 'should return xml' do
    result = @api.amplify_this(:output_format => :xml, :input_text => @input_text)
    Nokogiri::XML(result).wont_be_nil
  end

  # TODO mocks, fixtures, to_pdf, to_json, etc.
end
