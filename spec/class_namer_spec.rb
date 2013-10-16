require 'sinatra'
require File.join(settings.root, 'spec_helper')

describe "The Class Namer App" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe "GET /index" do

    before { get '/' }

    it "is ok" do
      expect(last_response).to be_ok
    end
  end

  describe "POST /suggestions" do

    context "given a keyword and a role" do

      it "is okay" do
        post '/suggestions', keywords: 'wheel', role: 'creation'
        expect(last_response).to be_ok
      end
    end
  end
end