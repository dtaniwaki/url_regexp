require 'spec_helper'

describe UrlRegexp::Query do
  subject { described_class.new }
  describe '#to_regexp_s' do
    context 'with various query' do
      it 'generates regexp' do
        subject.append('a=1')
        subject.append('b=1')
        regexp_s = subject.to_regexp_s
        expect(regexp_s).to eq '(\\?.*)?'
      end
    end
    context 'with common query' do
      it 'generates regexp' do
        subject.append('a=1')
        subject.append('a=1&b=1')
        regexp_s = subject.to_regexp_s
        expect(regexp_s).to eq '\\?(.*&)?a=1(&.*)?'
      end
    end
    context 'with multiple common queries' do
      it 'generates regexp' do
        subject.append('a=1&b=1')
        subject.append('a=1&b=1')
        regexp_s = subject.to_regexp_s
        expect(regexp_s).to eq '\\?((.*&)?a=1.*&b=1(&.*)?|(.*&)?b=1.*&a=1(&.*)?)'
      end
    end
  end
end
