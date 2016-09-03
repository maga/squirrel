module Squirrel
  class FetchFiles < ManageFiles

    def post_initialize
      fetch_files
    end

    def fetch_files
      files.each do |file|
        FetchFile.new(file)
      end
    end

    private

    FetchFile = Struct.new(:file) do
      include Client

      def initialize(*args)
        super
        fetch_file
      end

      def fetch_file
        File.open(file.filename, "w") { |f| f.write file_values }
      end

      def file_values
        file_chunks.values.join
      end

      def file_chunks
        client.get_multi(chunks_keys)
      end

      def chunks_keys
        client.get(file.basename)
      end
    end
  end
end
