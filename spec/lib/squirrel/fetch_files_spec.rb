require "spec_helper"

describe Squirrel::FetchFiles do
  let(:options) { { namespace: "app_v1", compress: true } }
  let(:dalli_client) { Dalli::Client.new("localhost:11211", options) }

  let(:filename) { File.expand_path("test.pdf", File.dirname(__FILE__)) }
  let!(:file_content) { File.read(filename) }
  let(:file) { File.open(filename, "w") }

  let(:file_chunks) { dalli_client.get_multi(file_keys) }

  before :each do
    Squirrel.save_files(filename)
    File.delete(filename)

    described_class.new(filenames: [filename])
  end

  after(:each) do
    # Delete file from memcached
  end

  it "fetches chunks" do
    puts File.expand_path(File.dirname(__FILE__))

    content = File.read(filename)

    expect(content).to eq file_content
  end

  it "fetches_files" do
    expect(File.file?(filename)).to eq true
  end
end
