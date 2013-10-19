require 'sinatra'
require 'slim'
Bundler.require(:default)
require File.join(File.dirname(__FILE__),'models', 'suggestion_request')

configure do
  set :views, File.dirname(__FILE__) + "/views"
  set :root, 	File.dirname(__FILE__)
end

Dinosaurus.configure do |config|
  config.api_key = 'c8cb86fe278eda9c3511e56cb4f43481'
end

get '/' do
  slim :index
end

post '/suggestions' do
  @suggestions = SuggestionRequest.new(params[:keyword], params[:role]).suggestions
  slim :suggestion
end