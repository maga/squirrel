module Squirrel
  class SaveFiles < ManageFiles
    attr_reader :files

    def post_initialize
      @files = FilesFactory.build(filenames: filenames)

      save_files
    end

    private

    def save_files
      files.each do |file|
        # TODO: Handle Errno::ENOENT: No such file or directory
        # return list of unexisted files and list of saved files
        FileCacher.new(file).cache if file.exists?
      end
    end

    FileCacher = Struct.new(:file) do
      include Client

      def cache
        file.each_chunk do |key, chunk|
          cache_value(key, chunk)
        end
        cache_keys
      end

      def cache_value(key, value)
        client.set(key, value)
      end

      def cache_keys
        cache_value(file.basename, file.chunks_keys)
      end
    end
  end
end
