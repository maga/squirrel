require "spec_helper"
require_relative "../shared_stuff.rb"

describe Squirrel::FileManager::FileCapsuleFetcher do
  include_context "shared stuff"

  context "when incapsulating unexisted file" do
    let(:fake) { described_class.new(filename: fake_file) }

    it "#exists? returns false" do
      expect(fake.exists?).to eq false
    end

    it "#get returns falsy value" do
      expect(fake.exists?).to be_falsy
    end
  end

  context "saving real file" do
    let(:file_capsule) { described_class.new(filename: filename) }

    it "incapsulates file" do
      expect(file_capsule).to be_truthy
    end

    before(:each) { Squirrel.save_files(filename) }

    it "#save saves file" do
      expect(file_capsule.get).to be_truthy
    end
  end
end

