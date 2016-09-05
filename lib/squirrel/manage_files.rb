require_relative "./file_manager/file_capsule"

module Squirrel
  class ManageFiles
    attr_reader :files, :errors

    def initialize(options)
      @files  = get_files(options)
      @errors = []

      post_initialize
    end

    def post_initialize
    end

    private

    def get_files(options)
      FilesFactory.build(filenames: options[:filenames],
                         file_class: file_capsule_class)
    end

    def file_capsule_class
      FileManager::FileCapsule
    end
  end
end
