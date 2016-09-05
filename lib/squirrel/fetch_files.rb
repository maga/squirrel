require_relative "./file_manager/file_capsule_fetcher"

module Squirrel
  class FetchFiles < ManageFiles
    def post_initialize
      fetch_files
    end

    private

    def file_capsule_class
      FileManager::FileCapsuleFetcher
    end

    def fetch_files
      files.each { |file| fetch_file(file) }
    end

    def fetch_file(file)
      file.get
    rescue => e
      errors << e.message
    end
  end
end
