require_relative "../lib/jstgenerator"

describe JstGenerator::Handlebars do
  after(:each) do
    File.delete("spec/fixtures/handlebars/jst.js") if File.exist?("spec/fixtures/handlebars/jst.js")
  end
  it "creates the JST file with the correct content" do
    hb = JstGenerator::Handlebars.new({
      :dir_glob => "spec/fixtures/handlebars/*.hb",
      :jst_path => "spec/fixtures/handlebars/jst.js"
    }).generate

    expect(File.exist?("spec/fixtures/handlebars/jst.js")).to eq true

    content = IO.read("spec/fixtures/handlebars/jst.js")
    expect(content).to eq(<<EOS)
window.JST = {};
window.JST["temp"] = Handlebars.compile("{{title}}");
EOS

  end

  it "works for multiple files" do
    hb = JstGenerator::Handlebars.new({
      :dir_glob => "spec/fixtures/handlebars/multiple/*.hb",
      :jst_path => "spec/fixtures/handlebars/jst.js"
    }).generate

    content = IO.read("spec/fixtures/handlebars/jst.js")
    expect(content).to eq(<<EOS)
window.JST = {};
window.JST["one"] = Handlebars.compile("{{title}}");
window.JST["two"] = Handlebars.compile("<p>{{desc}}</p>");
EOS

  end
end
