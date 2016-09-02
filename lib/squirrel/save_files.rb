module Squirrel
  class SaveFiles < ManageFiles
    attr_reader :files

    # TODO: move CHUNK size to config
    def post_initialize
      @files = FilesFactory.build(filenames: filenames)

      save_files
    end

    private

    def save_files
      files.each do |file|
        # TODO: return list of unexisted files
        # and list of saved files
        FileCacher.new(file).cache if file.exists?
      end
    end

    FileCacher = Struct.new(:file) do
      OPTIONS = { namespace: "app_v1", compress: true }

      def cache
        file.each_chunk do |key, chunk|
          cache_value(key, chunk)
        end
        cache_keys
      end

      def cache_value(key, value)
        dalli_client.set(key, value)
      end

      def cache_keys
        cache_value(file.basename, file.chunk_keys)
      end

      def dalli_client
        Dalli::Client.new("localhost:11211", OPTIONS)
      end
    end
  end
end
