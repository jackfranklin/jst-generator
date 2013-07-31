require_relative "../lib/jstgenerator"

describe JstGenerator::Engine do
  it "can glob for files" do
    engine = JstGenerator::Engine.new(:dir_glob => "spec/fixtures/*.hb")
    expect(engine.files.size).to eq 1
    expect(engine.files.first).to eq "spec/fixtures/test.hb"
  end
end
