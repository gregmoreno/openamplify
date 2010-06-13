require 'test/unit'
require 'shoulda'
require 'openamplify'

class OpenAmplifyTest < Test::Unit::TestCase

  context "Client instance" do

    should "raise an error if api key is missing" do
      assert_raises ArgumentError do 
        client = OpenAmplify::Client.new
        client.analyze_text("sample")
      end
    end

    should "raise an error if api_url is missing" do
      assert_raises ArgumentError do
        client = OpenAmplify::Client.new(:api_key => 'SOME_KEY')
        client.api_url = ''
        client.analyze_text('sample')
      end
    end


  end # context "Client instance"

end # OpenAmplifyTest
