require "spec_helper"

describe Squirrel::FileCapsule do
  context "when incapsulating unexisted file" do
    let(:fake_file) { described_class.new(filename: "fake.qw") }

    it "#exists? returns false" do
      expect(fake_file.exists?).to eq false
    end
  end

  context "when incapsulating existed file" do
    let(:options) { { namespace: "app_v1", compress: true } }
    let(:dalli_client) { Dalli::Client.new("localhost:11211", options) }
    let(:chunk_size) { 1024000.0 }
    let(:filename) { File.expand_path("test.pdf", File.dirname(__FILE__)) }
    let(:file) { File.open(filename) }
    let(:file_capsule) { described_class.new(filename: filename) }
    let(:chunks_amount) { (file.size / chunk_size).ceil }
    let(:chunks_keys) { chunks_amount.times.with_object([]) { |i, array| array << "#{basename}_#{i}" } }
    let(:basename) { File.basename(filename) }

    it "#exists? returns true" do
      expect(file_capsule.exists?).to eq true
    end

    it "#chunks.length == file.size / chunk_size" do
      expect(file_capsule.chunks_keys.size).to eq chunks_amount
    end

    it "has chunks_keys" do
      expect(file_capsule.chunks_keys).to eq chunks_keys
    end
  end

end
