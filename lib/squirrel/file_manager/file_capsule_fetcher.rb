module Squirrel
  module FileManager
    class FileCapsuleFetcher < FileCapsule
      def get
        (raise "No such file #{filename}" and return) unless exists?

        write_file
      end

      private

      def exists?
        !!chunks_keys
      end

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
