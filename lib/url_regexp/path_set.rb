require_relative './node'

module UrlRegexp
  class PathSet < Node
    include Enumerable
    extend Forwardable

    def_delegators :@set, :size, :hash, *Enumerable.public_instance_methods(false)

    def initialize(set = Set.new)
      @set = set
    end

    def append(path)
      set << path
    end

    def &(other)
      self.class.new(set & other.set)
    end

    def |(other)
      self.class.new(set & other.set)
    end

    def to_regexp_s
      s = if 5 < size
        "([^#?]*)"
      elsif 1 < size
        children_paths = map(&:paths).reduce { |s1, s2| s1 & s2 }
        if children_paths.size == 1
          "(#{map(&:label).join("|")})/#{children_paths.to_regexp_s}"
        else
          "(#{map(&:to_regexp_s).join("|")})"
        end
      elsif 1 == size
        to_a.first.to_regexp_s
      else
        nil
      end
    end

    protected

    attr_reader :set
  end
end
