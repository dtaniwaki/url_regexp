require 'spec_helper'

describe UrlRegexp::Root do
  subject { described_class.new }
  describe '#to_regexp_s' do
    it 'generates regexp' do
      subject.append('http://example.com/foo/bar?a=1&b=2')
      subject.append('http://example.com/foo/wow?a=1&b=1')
      regexp_s = subject.to_regexp_s
      expect(regexp_s).to eq '^http://example\\.com/foo/(bar|wow)\\?(.*&)?a=1(&.*)?(#|$)'
    end
    context 'Replace redundant URL end' do
      it 'generates regexp' do
        subject.append('http://example.com/foo/bar')
        subject.append('http://example.com/foo/wow')
        regexp_s = subject.to_regexp_s
        expect(regexp_s).to eq '^http://example\\.com/foo/(bar|wow)([?#]|$)'
      end
    end
  end
end
