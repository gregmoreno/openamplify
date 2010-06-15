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

    should "not raise an error if api key is present" do
      assert_nothing_raised do
        client.analyze_text("sample")
      end
    end

    should "raise an error if api key is not authorized" do
      assert_raises OpenAmplify::Forbidden do
        client = OpenAmplify::Client.new(:api_key => 'SOME_KEY')
        client.analyze_text("sample").reload
      end
    end

    should "raise an error if api_url is missing" do
      assert_raises ArgumentError do
        client.api_url = ''
        client.analyze_text('sample')
      end
    end

    should "not raise an error if api_url is present" do
      assert_nothing_raised do
        client.analyze_text('sample')
      end
    end

  end # context "Client instance"
  
  context "Response" do
  
    should "raise an error if empty text" do
      assert_raises OpenAmplify::NotAcceptable do
        client.analyze_text('').reload
      end
    end

    should "not raise an error if there is input text" do
      assert_nothing_raised do
        client.analyze_text('sample').reload
      end
    end

    should "raise error if analyis is not supported" do
      assert_raises OpenAmplify::NotSupported do
        client.analysis = 'not supported'
        client.analyze_text('sample').reload
      end
    end

    #pending "show the request url"

  end  # Response

  context "Request methods" do

    
    should "raise an error if not supported" do
      assert_raises OpenAmplify::NotSupported do
        client.method = :delete
        client.analyze_text('sample').reload
      end
    end

    [:get, :post].each do |method|
      should "not raise error for #{method}" do
        assert_nothing_raised do
          client.method = method
          client.analyze_text('sample').reload
        end
      end
    end

  end # Request methods

  def client
    @client ||= OpenAmplify::Client.new(:api_key => api_key)
  end

  def api_key
    ENV['OPEN_AMPLIFY_KEY']
  end

end # OpenAmplifyTest
