require 'spec_helper'

describe UrlRegexp::Path do
  subject { described_class.new }

  describe '#to_regexp_s' do
    context 'only root' do
      it 'returns regexp string' do
        subject.append('/')
        expect(subject.to_regexp_s).to eq '/'
      end
    end
    context 'append same paths' do
      it 'returns regexp string' do
        subject.append('/foo')
        expect(subject.to_regexp_s).to eq '/foo'
        subject.append('/foo')
        expect(subject.to_regexp_s).to eq '/foo'
      end
    end
    context 'simple paths' do
      it 'returns regexp string' do
        subject.append('/foo/bar')
        expect(subject.to_regexp_s).to eq '/foo/bar'
        subject.append('/foo/wow')
        expect(subject.to_regexp_s).to eq '/foo/(bar|wow)'
      end
    end
    context 'include path end' do
      it 'returns regexp string' do
        subject.append('/foo')
        subject.append('/foo/')
        expect(subject.to_regexp_s).to eq '/foo(/)?'
        subject.append('/foo/bar')
        expect(subject.to_regexp_s).to eq '/foo(/(|bar))?'
      end
    end
  end
end
