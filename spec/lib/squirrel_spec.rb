require "spec_helper"

describe Squirrel do
  let(:filename) { File.expand_path("test.pdf", __dir__) }

  context "saving real file" do
    before { described_class.save_files(filename) }

    it "responds with true" do
      expect(described_class.save_files(filename)).to be_truthy
    end
  end
end
