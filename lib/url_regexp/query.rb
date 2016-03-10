module UrlRegexp
  class Query
    def initialize(options = {})
      @queries = []
      @options = options
    end

    def append(query)
      return if query.nil?
      @queries << query.to_s.split('&').reject(&:empty?)
    end

    def to_regexp_s
      common_queries = @queries.reduce { |a, e| a & e } || []
      common_queries = common_queries.map { |q| Regexp.quote(q) }
      if 1 < common_queries.size
        "\\?(#{common_queries.permutation.map { |qs| "(.*&)?#{qs.join('.*&')}(&.*)?" }.join('|')})"
      elsif 1 == common_queries.size
        "\\?(.*&)?#{common_queries.first}(&.*)?"
      else
        '(\\?.*)?'
      end
    end
  end
end
