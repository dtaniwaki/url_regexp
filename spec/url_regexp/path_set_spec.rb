require 'spec_helper'

describe UrlRegexp::PathSet do
  subject { described_class.new }

  describe '#to_regexp_s' do
    context 'empty set' do
      it 'returns nil' do
        expect(subject.to_regexp_s).to eq nil
      end
    end
    context 'single path' do
      it 'returns regexp string' do
        subject.append(UrlRegexp::Path.new('foo'))
        expect(subject.to_regexp_s).to eq 'foo'
      end
    end
    context 'multiple paths' do
      it 'returns regexp string' do
        subject.append(UrlRegexp::Path.new('foo'))
        subject.append(UrlRegexp::Path.new('bar'))
        expect(subject.to_regexp_s).to eq '(foo|bar)'
      end
      context 'same prefix paths' do
        it 'returns regexp string' do
          subject.append(UrlRegexp::Path.new('bar'))
          subject.append(UrlRegexp::Path.new('bal'))
          subject.append(UrlRegexp::Path.new('baz'))
          expect(subject.to_regexp_s).to eq 'ba(r|l|z)'
        end
      end
    end
    context 'massive paths' do
      context '6 paths' do
        it 'returns regexp string' do
          subject.append(UrlRegexp::Path.new('a'))
          subject.append(UrlRegexp::Path.new('b'))
          subject.append(UrlRegexp::Path.new('c'))
          subject.append(UrlRegexp::Path.new('d'))
          subject.append(UrlRegexp::Path.new('e'))
          expect(subject.to_regexp_s).to eq '(a|b|c|d|e)'
        end
      end
      context '6 paths' do
        it 'returns regexp string' do
          subject.append(UrlRegexp::Path.new('a'))
          subject.append(UrlRegexp::Path.new('b'))
          subject.append(UrlRegexp::Path.new('c'))
          subject.append(UrlRegexp::Path.new('d'))
          subject.append(UrlRegexp::Path.new('e'))
          subject.append(UrlRegexp::Path.new('f'))
          expect(subject.to_regexp_s).to eq '([^#?]*)'
        end
      end
    end
    context 'merge paths' do
      it 'returns regexp string' do
        parent = UrlRegexp::Path.new
        p1 = UrlRegexp::Path.new('foo', parent)
        p1.append('wow')
        p2 = UrlRegexp::Path.new('bar', parent)
        p2.append('wow')

        subject.append(p1)
        subject.append(p2)
        expect(subject.to_regexp_s).to eq '(foo|bar)/wow'
      end
      context 'with multiple paths' do
        it 'returns regexp string' do
          parent = UrlRegexp::Path.new
          p1 = UrlRegexp::Path.new('foo', parent)
          p1.append('wow/yay')
          p2 = UrlRegexp::Path.new('bar', parent)
          p2.append('wow/yay')

          subject.append(p1)
          subject.append(p2)
          expect(subject.to_regexp_s).to eq '(foo|bar)/wow/yay'
        end
      end
      context 'include path_end' do
        it 'returns regexp string' do
          parent = UrlRegexp::Path.new
          p1 = UrlRegexp::Path.new('foo', parent)
          p1.path_end = true
          p1.append('wow')
          p2 = UrlRegexp::Path.new('bar', parent)
          p2.append('wow')

          subject.append(p1)
          subject.append(p2)
          expect(subject.to_regexp_s).to eq '(foo(/wow)?|bar/wow)'
        end
      end
    end
  end
end
