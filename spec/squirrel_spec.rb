require 'spec_helper'

describe Squirrel do
  let(:file_absolute_path) { File.expand_path("test.pdf", __dir__) }
  let(:file) { File.open(file_absolute_path, "r") }
  let(:basename) { File.basename(file_absolute_path) }
  let(:file_chunks_amount) { file.size / 1024000 }
  let(:file_keys) do
    (0..file_chunks_amount).inject([]) do |keys, i|
      keys << "#{basename}_#{i}"
    end
  end
  let(:file_chunks) { dalli_client.get_multi(file_keys) }

  context "saving fake file" do
    it "raises error" do
      expect { described_class.save_files("fake_file.xxx") }.to raise_error(Errno::ENOENT)
    end
  end

  context "saving real file" do
    before { described_class.save_files(file_absolute_path) }

    it "saves chunks" do
      expect(file_chunks.keys).to eq(file_keys)
    end

    it "saves chunks names" do
      expect(dalli_client.get(basename)).to eq(file_keys)
    end

    xit "saves chunks" do
      content = file_chunks.inject([]) do |chunk, array|
        array << chunk
      end.join

      expect(file).to have_file_content
    end
  end

end

OPTIONS = { namespace: "app_v1", compress: true }
def dalli_client
  Dalli::Client.new("localhost:11211", OPTIONS)
end
