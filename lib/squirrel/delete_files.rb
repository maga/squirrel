require_relative "./file_manager/file_capsule_deleter"

module Squirrel
  class DeleteFiles < ManageFiles
    def post_initialize
      delete_files
    end

    private

    def file_capsule_class
      FileManager::FileCapsuleDeleter
    end

    def delete_files
      files.each { |file| delete_file(file) }
    end

    def delete_file(file)
      file.delete
    rescue => e
      errors << e.message
    end
  end
end
