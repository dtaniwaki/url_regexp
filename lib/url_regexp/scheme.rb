require_relative './node'

module UrlRegexp
  class Scheme < Node
    def initialize(options = {})
      @schemes = Set.new
      @options = options
    end

    def append(scheme)
      @schemes << scheme
    end

    def to_regexp_s
      schemes = @schemes.map { |s| Regexp.quote(s) }
      if schemes == %w(http https)
        'https?://'
      elsif 1 < @schemes.size
        "(#{schemes.join('|')})://"
      elsif 1 == @schemes.size
        "#{schemes.to_a.first}://"
      else
        ''
      end
    end
  end
end
