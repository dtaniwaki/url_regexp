require 'spec_helper'

describe UrlRegexp::Node do
  subject { described_class.new }

  describe '#append' do
    it 'raises NotImplementedError' do
      expect { subject.append('') }.to raise_error(NotImplementedError)
    end
  end
  describe '#to_regexp_s' do
    it 'raises NotImplementedError' do
      expect { subject.to_regexp_s }.to raise_error(NotImplementedError)
    end
  end
  describe '#to_regexp' do
    it 'returns regexp of to_regexp_s' do
      allow(subject).to receive(:to_regexp_s).and_return('foo[bar]')
      expect(subject.to_regexp).to eq(/foo[bar]/)
    end
  end
end
