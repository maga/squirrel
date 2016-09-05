module Squirrel
  class FilesFactory
    def self.build(options, file_class = FileManager::FileCapsule)
      filenames = options[:filenames]
      target_class = options[:file_class] || file_class

      options[:filenames].collect do |filename|
        target_class.new(filename: filename)
      end
    end
  end
end
