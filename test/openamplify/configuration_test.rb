# require File.dirname(__FILE__) + '../helper'
require 'helper'

describe OpenAmplify do

  after do
    OpenAmplify.reset
  end

  describe '.configure' do
    OpenAmplify::Configuration::VALID_OPTIONS_KEYS.each do |key|
      it "should set the #{key}" do 
        OpenAmplify.configure do |config|
          config.send("#{key}=", key)
          OpenAmplify.send(key).must_equal key
        end
      end
    end
  end

  describe '.user_agent' do 
    it 'should return the default user agent' do
      OpenAmplify.user_agent.must_equal OpenAmplify::Configuration::DEFAULT_USER_AGENT
    end
  end

  describe '.endpoint' do
    it 'should return the default endpoint' do
      OpenAmplify.endpoint.must_equal OpenAmplify::Configuration::DEFAULT_ENDPOINT
    end
  end

  describe '.http_method' do
    it 'should return the default http method' do
      OpenAmplify.http_method.must_equal OpenAmplify::Configuration::DEFAULT_HTTP_METHOD
    end
  end

end
