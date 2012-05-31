require 'openamplify/configuration'
require 'openamplify/client'

module OpenAmplify
  extend Configuration

  def new(options={})
    Client.new(options)
  end

  # Delegate to OpenAmplify::Client

  def method_missing(method, *args, &block)
    return super unless new.respond_to?(method)
    new.send(method, *args, &block)
  end

  def respond_to?(method, include_private = false)
    new.respond_to?(method, include_private) || super(method, include_private)
  end

end # module OpenAmplify

