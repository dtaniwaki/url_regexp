module UrlRegexp
  class Node
    def append(_)
      raise NotImplementedError
    end

    def to_regexp_s
      raise NotImplementedError
    end

    def to_regexp
      rs = to_regexp_s
      Regexp.new(rs)
    end
  end
end
