module UrlRegexp
  class Query
    def initialize(options = {})
      @include_nil = false
      @queries = []
      @options = options
    end

    def append(query)
      query = query.to_s
      if query.empty?
        @include_nil = true
        return
      end
      @queries << query.split('&')
    end

    def to_regexp_s
      common_queries = @queries.reduce { |a, e| a & e } || []
      common_queries = common_queries.map { |q| Regexp.quote(q) }
      if 1 <= common_queries.size
        regexp_s = if 1 == common_queries.size
          "\\?(.*&)?#{common_queries.first}(&.*)?"
        else
          "\\?(#{common_queries.permutation.map { |qs| "(.*&)?#{qs.join('.*&')}(&.*)?" }.join('|')})"
        end
        @include_nil ? "(#{regexp_s})?" : regexp_s
      else
        '(\\?.*)?'
      end
    end
  end
end
