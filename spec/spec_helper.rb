ENV['RACK_ENV'] = 'test'

require File.join File.dirname(__FILE__), '../class_namer'  # <-- your sinatra app
require 'rspec'
require 'rack/test'