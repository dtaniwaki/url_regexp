require_relative './node'

module UrlRegexp
  class Scheme < Node
    def initialize
      @schemes = Set.new
    end

    def append(scheme)
      @schemes << scheme
    end

    def to_regexp_s
      schemes = @schemes.map { |s| Regexp.quote(s) }
      s = if schemes == %w(http https)
        "https?://"
      elsif 1 < @schemes.size
        "(#{schemes.join('|')})://"
      elsif 1 == @schemes.size
        "#{schemes.to_a.first.to_s}://"
      else
        ""
      end
      s
    end
  end
end
