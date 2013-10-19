ENV['RACK_ENV'] = 'test'

require 'rubygems'
require 'bundler'

require File.join(File.dirname(__FILE__), '../nominate.rb')

Bundler.require(:test)
require 'rspec'
require 'rack/test'