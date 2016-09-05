require "spec_helper"
require_relative "./shared_stuff"

describe Squirrel::SaveFiles do
  include_context "shared stuff"

  let(:saved_files) { described_class.new(filenames: [filename, fake_file]) }

  it "returns valid object" do
    errors = saved_files.errors
    files  = saved_files.files
    file = files.first

    expect(errors).to be_a Array
    expect(errors.size).to eq 1
    expect(errors[0]).to eq "No such file #{fake_file}"
    expect(files).to be_a Array
    expect(file).to respond_to :save
  end
end
