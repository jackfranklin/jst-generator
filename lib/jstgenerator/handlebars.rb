module JstGenerator
  class Handlebars < Engine
    def url
      "https://raw.github.com/wycats/handlebars.js/1.0.0/dist/handlebars.js"
    end

    def method
      "Handlebars.compile"
    end
  end
end
