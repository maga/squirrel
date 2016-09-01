require "squirrel/version"
require "squirrel/manage_files"
require "squirrel/files_factory"
require "squirrel/file_capsule"
require "squirrel/save_files"
# require "squirrel/fetch_files"
# require "squirrel/delete_files"

# General file management interface
# Usage:
# Squirrel.save_files("/files/filename.txt")
# class Foo
#   include Squirrel
# end
# Foo.new.save_files("files/filename.txt")
module Squirrel
  def save_files(*filenames)
    SaveFiles.new(filenames: filenames)
  end

  def fetch_files(*filenames)
    FetchFiles.new(filenames: filenames)
  end

  def delete_files(*filenames)
    DeleteFiles.new(filenames: filenames)
  end

  module_function :save_files, :fetch_files, :delete_files
end
