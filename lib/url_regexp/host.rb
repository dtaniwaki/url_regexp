module UrlRegexp
  class Host < Node
    def initialize
      @hosts = Set.new
    end

    def append(host)
      @hosts << host
    end

    def to_regexp_s
      hosts = @hosts.map { |h| Regexp.quote(h.to_s) }
      if 1 < hosts.size
        hosts = "(#{hosts.join('|')})"
      else
        hosts = hosts[0]
      end
      hosts
    end
  end
end
