require "spec_helper"

describe Squirrel::SaveFiles do
  let(:filename) { File.expand_path("test.pdf", __dir__) }

  let(:options) { { namespace: "app_v1", compress: true } }
  let(:dalli_client) { Dalli::Client.new("localhost:11211", options) }

  after { dalli_client.delete(filename) }

  # context "saving fake file" do

  # end

  context "saving real file" do
    it "responds with true" do
      expect(described_class.new(filenames: [filename])).to be_truthy
    end
  end
end
