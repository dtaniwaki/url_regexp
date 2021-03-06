require_relative './node'
require_relative './path_set'

module UrlRegexp
  class Path < Node
    attr_reader :label, :paths
    attr_accessor :path_end

    def initialize(label = nil, parent = nil, options = {})
      @label = label
      @parent = parent
      @options = options
      @paths = PathSet.new(nil, @options)
      @path_end = false
    end

    def ==(other)
      self.class == other.class &&
        @label == other.label &&
        @paths == other.paths &&
        @path_end == other.path_end
    end

    alias eql? ==

    def hash
      [@label, @paths, @path_end].hash
    end

    def append(path)
      if path == ''
        @paths.append(Path.new('', self, @options))
      elsif @parent.nil?
        _, label, rest = path.split('/', 3)
      else
        label, rest = path.split('/', 2)
      end
      return if label.nil?

      p = @paths.find { |pp| pp.label == label }
      if p.nil?
        p = Path.new(label, self, @options)
        @paths.append(p)
      end
      if rest.nil?
        p.path_end = true
      else
        p.append(rest)
      end
    end

    def to_regexp_s
      s = @paths.to_regexp_s
      s = "/#{s}" unless s.nil?
      s = "(#{s})?" if @path_end && s.to_s != ''
      s = "#{Regexp.quote(@label)}#{s}" if @label
      s
    end
  end
end
