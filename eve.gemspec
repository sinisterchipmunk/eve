# -*- encoding: utf-8 -*-

require File.expand_path('lib/eve/version', File.dirname(__FILE__))

Gem::Specification.new do |s|
  s.name = "eve"
  s.version = Eve::VERSION

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Colin MacKenzie IV"]
  s.date = "2012-02-15"
  s.description = "A Ruby library for interfacing with all aspects of the EVE Online MMO. It is designed for use within a Ruby on Rails project, but does not require Rails as a dependency. That means there is nothing preventing you from writing a stand-alone application or script using this library."
  s.email = "sinisterchipmunk@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/**/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n")

  s.homepage = "http://thoughtsincomputation.com"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "A Ruby library for interfacing with all aspects of the EVE Online MMO."

  s.add_runtime_dependency 'nokogiri', "~> 1"
  s.add_runtime_dependency 'activesupport', "~> 3"
  s.add_runtime_dependency 'sc-core-ext'
  
  s.add_development_dependency 'rails', ">= 0"
  s.add_development_dependency 'rspec-rails', "~> 2"
  s.add_development_dependency 'bundler', "~> 1"
end

