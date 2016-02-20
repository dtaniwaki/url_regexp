module UrlRegexp
  class Node
    def eql?(other)
      hash == other.hash
    end

    def append(_)
      fail NotImplementedError
    end

    def to_regexp_s
      fail NotImplementedError
    end

    def to_regexp
      rs = to_regexp_s
      Regexp.new(rs)
    end
  end
end
