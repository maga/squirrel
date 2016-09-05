require "spec_helper"
require_relative "./shared_stuff.rb"

describe Squirrel::DeleteFiles do
  include_context "shared stuff"

  let(:deleted_files) { described_class.new(filenames: [filename, fake_file]) }

  before(:each) { Squirrel.save_files(filename) }

  it "returns valid object" do
    errors = deleted_files.errors
    files  = deleted_files.files
    file   = files.first

    expect(errors).to be_a Array
    expect(errors.size).to eq 1
    expect(files).to be_a Array
    expect(file).to respond_to :delete
  end
end
