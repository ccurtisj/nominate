ENV['RACK_ENV'] = 'test'

require File.join settings.root, '../class_namer'  # <-- your sinatra app
require 'rspec'
require 'rack/test'