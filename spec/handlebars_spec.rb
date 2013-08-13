require_relative "../lib/jstgenerator"

describe JstGenerator::Handlebars do
  jst_path = "spec/fixtures/handlebars/jst.js"
  after(:each) do
    File.delete(jst_path) if File.exist?(jst_path)
  end
  it "creates the JST file with the correct content" do
    hb = JstGenerator::Handlebars.new({
      :dir_glob => "spec/fixtures/handlebars/*.hb",
      :jst_path => jst_path
    }).generate

    content = IO.read(jst_path)
    expect(content).to eq(<<EOS)
window.JST = {};
window.JST["temp"] = Handlebars.compile("{{title}}");
EOS

  end

  it "works for multiple files" do
    hb = JstGenerator::Handlebars.new({
      :dir_glob => "spec/fixtures/handlebars/multiple/*.hb",
      :jst_path => jst_path
    }).generate

    content = IO.read(jst_path)
    expect(content).to eq(<<EOS)
window.JST = {};
window.JST["one"] = Handlebars.compile("{{title}}");
window.JST["two"] = Handlebars.compile("<p>{{desc}}</p>");
EOS

  end

  it "handles nested files" do
    hb = JstGenerator::Handlebars.new({
      :dir_glob => "spec/fixtures/handlebars/nested/**/*.hb",
      :jst_path => jst_path
    }).generate

    content = IO.read(jst_path)
    expect(content).to eq(<<EOS)
window.JST = {};
window.JST["test/one"] = Handlebars.compile("{{title}}");
window.JST["two"] = Handlebars.compile("<p>{{desc}}</p>");
EOS
  end

  it "escapes double quotes" do
    hb = JstGenerator::Handlebars.new({
      :dir_glob => "spec/fixtures/handlebars/quotes/*.hbs",
      :jst_path => jst_path
    }).generate

    content = IO.read(jst_path)
    expect(content).to eq(<<EOS)
window.JST = {};
window.JST["test"] = Handlebars.compile("I'm \\\"doubled quoted\\\"");
EOS

  end
end
