require 'helper'

describe OpenAmplify::Client do

  before do
    @keys = OpenAmplify::Configuration::VALID_CONFIG_KEYS
  end

  describe 'with module configuration' do
    before do
      OpenAmplify.configure do |config|
        @keys.each do |key|
          config.send("#{key}=", key)
        end
      end
    end

    after do
      OpenAmplify.reset
    end

    it "should inherit module configuration" do
      api = OpenAmplify::Client.new
      @keys.each do |key|
        api.send(key).must_equal key
      end
    end

    describe 'with class configuration' do
      before do
        @config = {
          :api_key       => 'ak',
          :analysis      => 'an',
          :output_format => 'of',
          :scoring       => 'sc',
          :endpoint      => 'ep',
          :user_agent    => 'ua',
          :http_method   => 'hm',
          :http_adapter  => 'ha',
        }
      end

      it 'should override module configuration' do
        api = OpenAmplify::Client.new(@config)

        @keys.each do |key|
          api.send(key).must_equal @config[key]
        end
      end

      it 'should override module configuration after' do
        api = OpenAmplify::Client.new

        @config.each do |key, value|
          api.send("#{key}=", value)
        end

        @keys.each do |key|
          api.send("#{key}").must_equal @config[key]
        end
      end

    end

  end

end
