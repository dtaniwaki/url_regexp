# url_regexp

[![Gem Version][gem-image]][gem-link]
[![Dependency Status][deps-image]][deps-link]
[![Build Status][build-image]][build-link]
[![Coverage Status][cov-image]][cov-link]
[![Code Climate][gpa-image]][gpa-link]

## Installation

Add the url_regexp gem to your Gemfile.

```ruby
gem "url_regexp"
```

And run `bundle install`.

## Usage

e.g.

```ruby
root = UrlRegexp::Root.new
root.append('http://www.example.com/foo/bar')
root.to_regexp
# => /^http:\/\/www\.example\.com\/foo\/bar([?#]|$)/
root.append('http://www.example.com/foo/bar/wow')
root.to_regexp
# => /^http:\/\/www\.example\.com\/foo\/bar(\/wow)?([?#]|$)/
root.append('http://www.example.com/boo/bar')
root.to_regexp
# => /^http:\/\/www\.example\.com\/(foo\/bar(\/wow)?|boo\/bar)([?#]|$)/
root.append('http://www.example.com/boo/bar/wow')
root.to_regexp
# => /^http:\/\/www\.example\.com\/(foo|boo)\/bar(\/wow)?([?#]|$)/
```

## Options

### wildcard_threshold (default: 5)

You can change the threshold to group paths as wildcard.

```ruby
root = UrlRegexp::Root.new(wildcard_threshold: 2)
root.append('http://www.example.com/foo')
root.to_regexp
# => /^http:\/\/www\.example\.com\/foo([?#]|$)/
root.append('http://www.example.com/bar')
root.to_regexp
# => /^http:\/\/www\.example\.com\/bar([?#]|$)/
root.append('http://www.example.com/wow')
root.to_regexp
# => /^http:\/\/www\.example\.com\/([^#?]*)([?#]|$)/
```

## Test

```bash
bundle exec rake
```

It will execute `rspec` and `rubocop`.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new [Pull Request](../../pull/new/master)

## Copyright

Copyright (c) 2016 Daisuke Taniwaki. See [LICENSE](LICENSE) for details.



[gem-image]:   https://badge.fury.io/rb/url_regexp.svg
[gem-link]:    http://badge.fury.io/rb/url_regexp
[build-image]: https://secure.travis-ci.org/dtaniwaki/url_regexp.svg?branch=master
[build-link]:  http://travis-ci.org/dtaniwaki/url_regexp?branch=master
[deps-image]:  https://gemnasium.com/dtaniwaki/url_regexp.svg?branch=master
[deps-link]:   https://gemnasium.com/dtaniwaki/url_regexp?branch=master
[cov-image]:   https://coveralls.io/repos/github/dtaniwaki/url_regexp/badge.svg?branch=master
[cov-link]:    https://coveralls.io/github/dtaniwaki/url_regexp?branch=master
[gpa-image]:   https://codeclimate.com/github/dtaniwaki/url_regexp.svg?branch=master
[gpa-link]:    https://codeclimate.com/github/dtaniwaki/url_regexp?branch=master

