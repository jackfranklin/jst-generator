require_relative "../lib/jstgenerator"

describe JstGenerator::Underscore do
  jst_path = "spec/fixtures/underscore/jst.js"
  after(:each) do
    File.delete(jst_path) if File.exist?(jst_path)
  end

  it "works for a single file" do
    under = JstGenerator::Underscore.new({
      :dir_glob => "spec/fixtures/underscore/*.us",
      :jst_path => jst_path
    }).generate
    content = IO.read(jst_path)
    expect(content).to eq(<<EOS)
window.JST = {};
window.JST["test"] = _.template("Hello World");
EOS

  end
end
