require "spec_helper"
require_relative "../shared_stuff.rb"

describe Squirrel::FileManager::FileCapsuleSaver do
  include_context "shared stuff"

  context "when incapsulating unexisted file" do
    let(:fake) { described_class.new(filename: fake_file) }

    it "#exists? returns false" do
      expect(fake.exists?).to eq false
    end

    it "#save returns falsy value" do
      expect(fake.exists?).to be_falsy
    end
  end

  context "saving real file" do
    let(:file_capsule) { described_class.new(filename: filename) }
    let(:chunk_size) { 1024000.0 }
    let(:file) { File.open(filename) }
    let(:chunks_amount) { (file.size / chunk_size).ceil }

    it "#chunks.length == file.size / chunk_size" do
      expect(file_capsule.chunks_keys.size).to eq chunks_amount
    end

    it "incapsulates file" do
      expect(file_capsule).to be_truthy
    end

    it "#save saves file" do
      expect(file_capsule.save).to be_truthy
    end
  end
end
