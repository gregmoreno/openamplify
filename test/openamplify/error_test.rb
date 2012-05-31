require 'helper'

describe OpenAmplify::Error do

  it 'should raise error when wrong or missing api key' do
    client = OpenAmplify::Client.new(:api_key => 'some random key')
    lambda { client.amplify_this 'sample' }.must_raise OpenAmplify::Error::Forbidden
  end

end
