require 'openamplify'
require 'minitest/spec'
require 'minitest/autorun'

require 'awesome_print'

OpenAmplify.configure do |config|
  config.api_key     = ENV['OPEN_AMPLIFY_KEY']
end
