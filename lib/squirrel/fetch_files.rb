module Squirrel
  class FetchFiles < ManageFiles

    def post_initialize(options)
      fetch_files
    end

    def fetch_files
      filenames.each do |filename|
        FetchFile(filename)
      end
    end

    private

    FetchFile = Struct.new(filename) do
      def initialize(*args)
        super
        fetch_file
      end

      def fetch_file
        chunks_of_file.each.with_object(empty_file) do |chunk, file|
          file << file_chunk(chunk)
        end
      end

      def chunks_of_file
        dalli_client.get(basename)
      end

      def empty_file
        File.open("filename", "w")
      end

      def basename
        File.basename(filename)
      end

      def file_chunk(key)
        dalli_client.get(key)
      end
    end
  end
end
