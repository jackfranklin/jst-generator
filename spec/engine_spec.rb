require_relative "../lib/jstgenerator"

describe JstGenerator::Engine do
  describe "globbing" do
    it "finds files" do
      engine = JstGenerator::Engine.new("spec/fixtures/*.hb")
      expect(engine.files.size).to eq 1
      expect(engine.files.first).to eq "spec/fixtures/test.hb"
    end
  end
end
