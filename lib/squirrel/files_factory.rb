module Squirrel
  class FilesFactory
    def self.build(options, file_class = FileCapsule)
      chunk_size = options[:chunk_size]

      options[:filenames].collect do |filename|
        file_class.new(filename: filename, chunk_size: chunk_size)
      end
    end
  end
end
