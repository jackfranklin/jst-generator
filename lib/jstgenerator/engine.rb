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

    def create_jst_file(contents = "")
      File.open(@jst_path, "w") { |f| f.puts contents }
    end

    def load_source
      @cxt = V8::Context.new
      base_dir = File.dirname(__FILE__)
      path = "#{base_dir}/../"
      @cxt.load("#{path}/js/#{filename}.js")
    end

    def process_template(path)
      contents = IO.read(path).gsub("\n", "")
      template_name = path.gsub(base_path, "").split(".").first
      "window.JST[\"#{template_name}\"] = #{method}(\"#{contents}\");"
    end

    def jst_heading
      "window.JST = {};"
    end

    def base_path
      @dir_glob.split("*").first
    end
  end
end
