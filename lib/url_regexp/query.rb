module UrlRegexp
  class Query
    def initialize
      @queries = []
    end

    def append(query)
      if !query.nil?
        @queries << query.to_s.split('&').reject(&:empty?)
      end
    end

    def to_regexp_s
      common_queries = @queries.reduce { |q1, q2| q1 & q2 } || []
      if 1 < common_queries.size
        "\\?(#{common_queries.map { |q| Regexp.quote(q) }.permutation.to_a.map { |qs| "(.*&)?#{qs.join('.*&')}(&.*)?" }.join('|')})"
      elsif 1 == common_queries.size
        "\\?(.*&)?#{Regexp.quote(common_queries.first)}(&.*)?"
      else
        "(\\?.*)?"
      end
    end
  end
end
