module Squirrel
  class FilesFactory
    def self.build(options, file_class = FileCapsule)
      options[:filenames].collect do |filename|
        file_class.new(filename: filename)
      end
    end
  end
end
