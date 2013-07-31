require 'open-uri'
require 'v8'
module JstGenerator
  class Engine
    attr_reader :files
    def initialize(opts = {})
      @dir_glob = opts.fetch(:dir_glob) { "**/*.hb" }
      @jst_path = opts.fetch(:jst_path) { "jst.js" }
      @files = Dir[@dir_glob]
    end

    def create_jst_file(contents = "")
      File.open(@jst_path, "w") { |f| f.puts contents }
    end

    def generate
      @jst_contents = [jst_heading]
      load_source
      @files.each do |file|
        content = process_template(file)
        @jst_contents.push(content)
      end
      create_jst_file(@jst_contents.join("\n"))
    end

    private

    def load_source
      source = open(url).read
      @cxt = V8::Context.new
      @cxt.eval(source)
    end

    def process_template(path)
      contents = IO.read(path).gsub("\n", "")
      "window.JST[\"#{File.basename(path).split(".").first}\"] = #{method}(\"#{contents}\");"
    end

    def jst_heading
      "window.JST = {};"
    end
  end
end
