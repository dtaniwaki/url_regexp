require_relative './node'

module UrlRegexp
  class Set < ::Set
    def include?(o)
      # Comparing keys directly is faster than rehash everytime for few items
      # @hash.rehash
      # super(o)
      @hash.keys.include?(o)
    end
  end

  class PathSet < Node
    extend Forwardable

    def_delegators :@set, :size, *Enumerable.public_instance_methods(false)

    def initialize(set = Set.new)
      @set = set
    end

    def append(path)
      set << path
    end

    def ==(other)
      self.class == other.class &&
        @set.to_a == other.set.to_a
    end

    alias eql? ==

    def hash
      @set.hash
    end

    def &(other)
      self.class.new(@set & other.set)
    end

    def |(other)
      self.class.new(@set & other.set)
    end

    def include?(path)
      @set.include?(path)
    end

    def to_regexp_s
      if 5 < size
        '([^#?]*)'
      elsif 1 < size
        children_paths = map(&:paths).reduce { |a, e| a & e }
        if children_paths.size == 1 && all? { |p| !p.path_end }
          "(#{map(&:label).join('|')})/#{children_paths.to_regexp_s}"
        else
          "(#{map(&:to_regexp_s).join('|')})"
        end
      elsif 1 == size
        to_a.first.to_regexp_s
      end
    end

    protected

    attr_reader :set
  end
end
