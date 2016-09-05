require "spec_helper"

describe Squirrel do
  let(:filename) { File.expand_path("test.pdf", __dir__) }

  context "save_filesving real file" do
    # delete this spec
    xit "responds with true" do
      expect(described_class.save_files(filename)).to be_truthy
    end
  end
end
