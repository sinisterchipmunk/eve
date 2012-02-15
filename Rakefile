require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  require './lib/eve/version'
  
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "eve"
  gem.homepage = "http://thoughtsincomputation.com"
  gem.license = "MIT"
  gem.summary = "A Ruby library for interfacing with all aspects of the EVE Online MMO."
  gem.description = "A Ruby library for interfacing with all aspects of the EVE Online MMO. It is designed for use "+
          "within a Ruby on Rails project, but does not require Rails as a dependency. That means there is nothing "+
          "preventing you from writing a stand-alone application or script using this library."
  gem.email = "sinisterchipmunk@gmail.com"
  gem.authors = ["Colin MacKenzie IV"]
  gem.version = Eve::VERSION
  # Include your dependencies below. Runtime dependencies are required when using your gem,
  # and development dependencies are only needed for development (ie running rake tasks, tests, etc)
  #  gem.add_runtime_dependency 'jabber4r', '> 0.1'
  #  gem.add_development_dependency 'rspec', '> 1.2.3'
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'rdoc/task'
RDoc::Task.new do |rdoc|
  require './lib/eve/version'
  version = Eve::VERSION

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "eve #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
