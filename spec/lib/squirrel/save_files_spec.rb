require "spec_helper"

describe Squirrel::SaveFiles do
  let(:filename) { File.expand_path("test.pdf", __dir__) }

  context "saving real file" do
    it "responds with true" do
      expect(described_class.new(filenames: [filename])).to be_truthy
    end
  end
end
