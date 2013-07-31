require_relative "../lib/jstgenerator"

describe JstGenerator::Engine do
  after(:each) do
    File.delete("spec/fixtures/jst.js") if File.exist?("spec/fixtures/jst.js")
  end
  it "can glob for files" do
    engine = JstGenerator::Engine.new(:dir_glob => "spec/fixtures/*.hb")
    expect(engine.files.size).to eq 1
    expect(engine.files.first).to eq "spec/fixtures/test.hb"
  end

  it "creates the JST file at the given path" do
    engine = JstGenerator::Engine.new(:jst_path => "spec/fixtures/jst.js").create_jst_file
    expect(File.exist?("spec/fixtures/jst.js")).to eq true
  end
end
