module UrlRegexp
  class Host < Node
    def initialize(options = {})
      @hosts = Set.new
      @options = options
    end

    def append(host)
      @hosts << host
    end

    def to_regexp_s
      hosts = @hosts.map { |h| Regexp.quote(h.to_s) }
      if 1 < hosts.size
        "(#{hosts.join('|')})"
      else
        hosts[0]
      end
    end
  end
end
