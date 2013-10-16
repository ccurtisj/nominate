require 'sinatra'
require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require File.join(File.dirname(__FILE__), '../..', 'models/suggestion_request')
require File.join(File.dirname(__FILE__), '../..', 'models/class_type')

describe SuggestionRequest do

  describe "#initialize" do

    let(:request) { SuggestionRequest.new('foo', 'batz')}

    it "should assign attributes" do
      expect(request.keyword).to eq 'foo'
      expect(request.role).to eq('batz')
    end
  end

  describe "#suggestions" do

    context "given a keyword" do

      let(:request) { SuggestionRequest.new('foo') }

      it "requests synonyms from big thesaurus" do
        Dinosaurus.should_receive(:synonyms_of)
          .with('foo')
          .and_return(['bar'])

        request.suggestions
      end
    end

    context "given a multiword synonym" do

      before { Dinosaurus.should_receive(:synonyms_of)
        .and_return(['bar bat baz'])}

      let(:suggestions) { SuggestionRequest.new('foo').suggestions }

      it "formats it in class style" do
        suggestions.should eq ['Foo', 'BarBatBaz']
      end
    end

    context "given duplicate synonyms" do

      before { Dinosaurus.should_receive(:synonyms_of)
        .and_return(['bar', 'bar'])}

      subject { SuggestionRequest.new('foo').suggestions }

      it { should eq ['Foo', 'Bar'] }
    end

    context "given a role" do

      let(:class_type) { ClassType.for_role('test_role') }
      let(:request) { SuggestionRequest.new('foo', 'test_role') }

      before do
        ClassType.should_receive(:for_role)
          .and_return(['Factory'])

        Dinosaurus.should_receive(:synonyms_of)
          .and_return(['bar'])
      end

      it "includes the related class types" do
        request.suggestions.should =~ ['Foo', 'Bar', 'FooFactory', 'BarFactory']
      end
    end
  end
end