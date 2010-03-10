$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'eve/dependencies'
require 'eve/errors'
require 'eve/api'

module Eve
  VERSION = '0.0.1'
end
