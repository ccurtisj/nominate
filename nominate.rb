require 'sinatra'
require 'slim'
require 'airbrake'

Bundler.require(:default)
require File.join(File.dirname(__FILE__),'models', 'suggestion_request')

configure do
  set :views, File.dirname(__FILE__) + "/views"
  set :root, 	File.dirname(__FILE__)

  use Rack::Session::Cookie, :key => 'rack.session', :secret => 'b65HVtXRTuQnf3Fb'
  use Airbrake::Rack

  enable :sessions
  enable :raise_errors
end

#
# Configuration
#
Dinosaurus.configure do |config|
  config.api_key = ENV['DINOSAURUS']
end

Airbrake.configure do |config|
  config.api_key = ENV['AIRBRAKE']
  # config.development_environments = []
end

get '/' do
  slim :index
end

post '/suggestions' do
  session['keyword'] = params[:keyword]
  session['role']    = params[:role]

  @suggestions = SuggestionRequest.new(params[:keyword], params[:role]).suggestions
  slim :suggestion
end