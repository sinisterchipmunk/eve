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

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "eve #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end


=begin
require 'rubygems'
gem 'hoe', '>= 2.1.0'
require 'hoe'
require 'fileutils'
require './lib/eve'

def rcov_opts
  IO.readlines("spec/rcov.opts").map {|l| l.chomp.split " "}.flatten
end

Hoe.plugin :newgem
# Hoe.plugin :website
# Hoe.plugin :cucumberfeatures

# Generate all the Rake tasks
# Run 'rake -T' to see list of generated tasks (from gem root directory)
$hoe = Hoe.spec 'eve' do
  self.version = Eve::VERSION
  #self.summary = Eve::VERSION::SUMMARY
  self.description = "A Ruby library for interfacing with all aspects of the EVE Online MMO. It is designed for use "+
          "within a Ruby on Rails project, but does not require Rails as a dependency. That means there is nothing "+
          "preventing you from writing a stand-alone application or script using this library."
  self.developer('Colin MacKenzie IV', 'sinisterchipmunk@gmail.com')
  self.url = ('http://github.com/sinisterchipmunk/eve')
  self.extra_deps << ["activesupport",">=2.3.5"] << ["hpricot",">=0.8.2"] << ["actionpack",">=2.3.5"]
  self.extra_dev_deps << ["cucumber",">=0.6.2"] << ["rspec",">=1.3.0"] << ["rcov",">=0.9.8"]
  self.rspec_options = ['--options', 'spec/spec.opts']
  #self.history_file = 'History.rdoc'
  self.readme_file = 'README.rdoc'
  self.post_install_message = ""
end

remove_task :docs

Rake::RDocTask.new(:docs) do |rdoc|
  files = ['README.rdoc', # 'LICENSE', 'CHANGELOG',
           'lib/**/*.rb', 'doc/**/*.rdoc']#, 'spec/*.rb']
  rdoc.rdoc_files.add(files)
  rdoc.main = 'README.rdoc'
  rdoc.title = 'EVE Documentation'
  #rdoc.template = '/path/to/gems/allison-2.0/lib/allison'
  rdoc.rdoc_dir = 'doc'
  rdoc.options << '--line-numbers' << '--inline-source'
end

require 'newgem/tasks'
Dir['tasks/**/*.rake'].each { |t| load t }

task :cleanup_rcov_files do
  rm_rf 'coverage.data'
end


if RUBY_VERSION =~ /^1.8/
  task :default => [:cleanup_rcov_files, :features, :verify_rcov]
else
  task :default => [:spec, :features]
end

namespace :spec do
  desc "Run all specs with rcov"
  Spec::Rake::SpecTask.new(:rcov) do |t|
    t.spec_files = FileList['spec/**/*_spec.rb']
    t.spec_opts = ['--options', 'spec/spec.opts']
    t.rcov = true
    t.rcov_dir = 'coverage'
    t.rcov_opts = rcov_opts
  end

  desc "Run files listed in spec/spec_files.txt"
  Spec::Rake::SpecTask.new(:focus) do |t|
    if File.exists?('spec/spec_files.txt')
      t.spec_files = File.readlines('spec/spec_files.txt').collect{|f| f.chomp}
    end
  end
end

begin
  require 'cucumber/rake/task'
  desc "Run Cucumber features"
  if RUBY_VERSION =~ /^1.8/
    Cucumber::Rake::Task.new :features do |t|
      t.rcov = true
      t.rcov_opts = rcov_opts
      t.cucumber_opts = %w{--format progress}
    end
  else
    task :features do
      sh 'cucumber --profile no_heckle'
    end
  end
rescue LoadError
  puts "You need cucumber installed to run cucumber tasks"
end

def egrep(pattern)
  Dir['**/*.rb'].each do |fn|
    count = 0
    open(fn) do |f|
      while line = f.gets
        count += 1
        if line =~ pattern
          puts "#{fn}:#{count}:#{line}"
        end
      end
    end
  end
end

desc "Look for TODO and FIXME tags in the code"
task :todo do
  egrep /(FIXME|TODO|TBD)/
end

namespace :update do
  desc "update the manifest"
  task :manifest do
    system %q[touch Manifest.txt; rake check_manifest | grep -v "(in " | patch]
  end
end

task :clobber => :clobber_tmp

task :clobber_tmp do
  cmd = %q[rm -r tmp]
  puts cmd
  system cmd if test ?d, 'tmp'
end
=end
