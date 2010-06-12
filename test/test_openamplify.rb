require 'test/unit'
require 'shoulda'
require 'openamplify'

class OpenAmplifyTest < Test::Unit::TestCase
  context "Client instance" do
    setup do
      @client = OpenAmplify::Client.new
    end
  end
end
