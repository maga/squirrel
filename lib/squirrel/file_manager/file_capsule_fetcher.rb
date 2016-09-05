module Squirrel
  module FileManager
    class FileCapsuleFetcher < FileCapsule
      def get
        (raise "No value found for #{filename}" and return) unless exists?

        write_file
      end

      def exists?
        !!chunks_keys
      end

      private

      def content
        MemcachedClient.get_multi(chunks_keys).values.join
      end

      def specify_keys
        MemcachedClient.get(basename)
      end

      def write_file
        ::File.open(filename, "w") { |f| f.write content }
      end
    end
  end
end
