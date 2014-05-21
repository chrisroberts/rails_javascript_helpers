$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__)) + '/lib/'
require 'rails_javascript_helpers/version'
Gem::Specification.new do |s|
  s.name = 'rails_javascript_helpers'
  s.version = RailsJavaScriptHelpers::VERSION.version
  s.summary = 'Javascript Helpers for Rails'
  s.author = 'Chris Roberts'
  s.email = 'code@chrisroberts.org'
  s.homepage = 'http://github.com/chrisroberts/rails_javascript_helpers'
  s.description = 'JavaScript helpers for rails'
  s.require_path = 'lib'
  s.add_dependency 'rails', '>= 2.3'
  s.files = Dir.glob("lib/**/*")
end
