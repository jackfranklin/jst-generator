# JST Generator

A gem for automatically generating a `jst.js` file full of compiled templates.

Currently supports __Handlebars__ and __Underscore__ out of the box, with more to come.

## Installation

Add this line to your application's Gemfile:

    gem 'jstgenerator'

And then execute:

    $ bundle


## Usage

### Within a Ruby app (such as Sinatra)
Within a Ruby app, you can do something like this:

```ruby
# or JstGenerator::Underscore.new for Underscore templates
JstGenerator::Handlebars.new({
    :dir_glob => "path/to/templates/*.hb",
    :jst_path => "output/jst.js"
}).generate
```

This will:

- create `output/jst.js` that creates a `window.JST` object
- loop through each file the `dir_glob` matches
- and add that to `window.JST`

An example `jst.js` file looks like so:

```js
window.JST = {};
window.JST["test"] = Handlebars.compile("My template {{title}}")
```

You can then load in `jst.js` and compile that template:

```js
var html = window.JST["test"]({ title: "Hello World" });
```

The advantage being the compilation step (`Handlebars.compile`) is only run once and that you can keep your templates in their own file, rather than within some HTML.

###Without a Ruby app (command line)
_CLI coming soon_

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
