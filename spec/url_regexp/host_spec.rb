require 'spec_helper'

describe UrlRegexp::Host do
  subject { described_class.new }

  describe '#to_regexp_s' do
    context 'single host' do
      it 'returns regexp string' do
        subject.append('www.example.com')
        expect(subject.to_regexp_s).to eq 'www\\.example\\.com'
      end
    end
    context 'multiple hosts' do
      it 'returns regexp string' do
        subject.append('www.example1.com')
        subject.append('www.example2.com')
        expect(subject.to_regexp_s).to eq '(www\\.example1\\.com|www\\.example2\\.com)'
      end
    end
  end
end
