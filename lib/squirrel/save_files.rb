require_relative "./file_manager/file_capsule_saver"

module Squirrel
  class SaveFiles < ManageFiles
    def post_initialize
      save_files
    end

    private

    def file_capsule_class
      FileManager::FileCapsuleSaver
    end

    def save_files
      files.each { |file| save_file(file) }
    end

    def save_file(file)
      file.save
    rescue => e
      errors << e.message
    end
  end
end
