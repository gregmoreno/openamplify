require 'openamplify'
require 'minitest/spec'
require 'minitest/autorun'

OpenAmplify.configure do |config|
  config.api_key     = ENV['OPEN_AMPLIFY_KEY']
  config.http_method = :post
end


