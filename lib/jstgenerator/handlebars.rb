module JstGenerator
  class Handlebars < Engine
    def filename
      "handlebars"
    end

    def method
      "Handlebars.compile"
    end
  end
end
