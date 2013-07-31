module JstGenerator
  class Engine
    attr_reader :files
    def initialize(dir_glob = "**/*.hb")
      @files = Dir[dir_glob]
    end
  end
end
