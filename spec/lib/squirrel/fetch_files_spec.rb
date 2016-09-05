require "spec_helper"
require_relative "./shared_stuff.rb"

describe Squirrel::FetchFiles do
  include_context "shared stuff"

  let(:fetched_files) { described_class.new(filenames: [filename, fake_file]) }

  before :each do
    Squirrel.save_files(filename)
    File.delete(filename)
  end

  it "returns valid object" do
    errors = fetched_files.errors
    files  = fetched_files.files
    file = files.first

    expect(errors).to be_a Array
    expect(errors.size).to eq 1
    expect(errors[0]).to eq "No value found for #{fake_file}"
    expect(files).to be_a Array
    expect(file).to respond_to :get
  end
end
