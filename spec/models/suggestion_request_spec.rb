require File.join(File.dirname(__FILE__), '..', 'spec_helper')

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

      before do
        Dinosaurus.should_receive(:synonyms_of)
          .and_return(['bar bat baz'])

        allow(ClassType).to receive(:for_role)
          .and_return([''])
      end

      let(:suggestions) { SuggestionRequest.new('foo').suggestions }

      it "formats it in class style" do
        suggestions.should eq ['Foo', 'BarBatBaz']
      end
    end

    context "given duplicate synonyms" do

      before do
        Dinosaurus.should_receive(:synonyms_of)
          .and_return(['bar', 'bar'])

        allow(ClassType).to receive(:for_role)
          .and_return([''])
      end

      subject { SuggestionRequest.new('foo').suggestions }

      it { should eq ['Foo', 'Bar'] }
    end

    context "given a role" do

      let(:request) { SuggestionRequest.new('foo', 'test_role') }

      before do
        ClassType.should_receive(:for_role)
          .and_return(['Factory'])

        Dinosaurus.should_receive(:synonyms_of)
          .and_return(['bar'])
      end

      it "includes the related class types" do
        request.suggestions.should =~ ['FooFactory', 'BarFactory']
      end
    end
  end
end