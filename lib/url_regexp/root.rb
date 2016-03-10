%w(scheme host path query).each do |m|
  require_relative "./#{m}"
end

module UrlRegexp
  class Root < Node
    def initialize(options = {})
      @scheme = Scheme.new(options)
      @host = Host.new(options)
      @path = Path.new(nil, nil, options)
      @query = Query.new(options)
      @options = options
    end

    def append(url)
      url = URI(url) unless url.is_a?(URI)
      @path.append(url.path)
      @scheme.append(url.scheme)
      @host.append(url.host)
      @query.append(url.query)
    end

    def to_regexp_s
      s = '^' +
          @scheme.to_regexp_s +
          @host.to_regexp_s +
          @path.to_regexp_s +
          @query.to_regexp_s +
          '(#|$)'
      s.sub('(\\?.*)?(#|$)', '([?#]|$)')
    end
  end
end
