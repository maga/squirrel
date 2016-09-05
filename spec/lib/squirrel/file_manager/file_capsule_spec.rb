require "spec_helper"
require_relative "../shared_stuff.rb"

describe Squirrel::FileManager::FileCapsule do
  include_context "shared stuff"

  context "saving real file" do
    let(:file_capsule) { described_class.new(filename: filename) }
    let(:chunk_size) { 1024000.0 }
    let(:basename) { File.basename(filename) }

    it "#exists? returns true" do
      expect(file_capsule.exists?).to eq true
    end

    it "responds to basename" do
      expect(file_capsule).to respond_to(:basename)
      expect(file_capsule.basename).to eq basename
    end

    it "incapsulates file" do
      expect(file_capsule).to be_truthy
    end
  end
end
