require 'sinatra'
require File.join(settings.root, 'spec_helper')

describe "The Class Namer App" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "says hello" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to eq('Hello World')
  end
end