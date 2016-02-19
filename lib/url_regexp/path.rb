require_relative './node'
require_relative './path_set'

module UrlRegexp
  class Path < Node
    attr_reader :label, :paths
    attr_accessor :path_end

    def initialize(label = nil, parent = nil)
      @label = label
      @parent = parent
      @paths = PathSet.new
      @path_end = false
    end

    def path_end?
      @path_end
    end

    def hash
      [@label, @paths.hash].hash
    end

    def append(path)
      if path == ''
        @paths.append(Path.new('', self))
      else
        if @parent.nil?
          _, label, rest = path.split('/', 3)
        else
          label, rest = path.split('/', 2)
        end
        if label
          unless p = @paths.find { |_p| _p.label == label }
            p = Path.new(label, self)
            @paths.append(p)
          end
          if rest.nil?
            p.path_end = true
          else
            p.append(rest)
          end
        end
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
