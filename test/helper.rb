require 'openamplify'
require 'minitest/spec'
require 'minitest/autorun'

require 'awesome_print'

OpenAmplify.configure do |config|
  config.api_key = ENV['OPEN_AMPLIFY_KEY']
end

def amplify_input
  fpath = File.dirname(__FILE__) + '/fixtures/input.txt'
  @amplify_params ||= File.read(fpath)
end
