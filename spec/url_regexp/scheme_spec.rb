require 'spec_helper'

describe UrlRegexp::Scheme do
  subject { described_class.new }

  describe '#to_regexp_s' do
    context 'single scheme' do
      it 'returns regexp string' do
        subject.append('http')
        expect(subject.to_regexp_s).to eq 'http://'
      end
    end
    context 'multiple schemes' do
      it 'returns regexp string' do
        subject.append('http')
        subject.append('https')
        subject.append('ftp')
        expect(subject.to_regexp_s).to eq '(http|https|ftp)://'
      end
    end
    context 'http and https' do
      it 'returns regexp string' do
        subject.append('http')
        subject.append('https')
        expect(subject.to_regexp_s).to eq 'https?://'
      end
    end
    context 'no scheme' do
      it 'returns regexp string' do
        expect(subject.to_regexp_s).to eq ''
      end
    end
  end
end
