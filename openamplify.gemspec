# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "openamplify/version"

Gem::Specification.new do |s|
  s.name        = "openamplify"
  s.version     = OpenAmplify::VERSION
  s.authors     = ["Greg Moreno"]
  s.email       = ["greg.moreno@gmail.com"]
  s.homepage    = ""
  s.summary     = "Wrapper for the OpenAmplify API"
  s.description = "The OpenAmplify API reads text you supply and returns linguistic data explaining and classifying the content."

  s.rubyforge_project = "openamplify"

  s.files         = `git ls-files`.split("\n")

  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'faraday'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'nokogiri'
  s.add_development_dependency 'json'
end
