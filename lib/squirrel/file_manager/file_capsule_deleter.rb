module Squirrel
  module FileManager
    class FileCapsuleDeleter < FileCapsule
      def delete
        (raise "No value found by key #{filename}" and return) unless exists?

        delete_chunks
        delete_keys
      end

      def exists?
        !!chunks_keys
      end

      private

      def delete_chunks
        chunks_keys.each do |key|
          MemcachedClient.delete(key)
        end
      end

      def delete_keys
        MemcachedClient.delete(basename)
      end

      def specify_keys
        MemcachedClient.get(basename)
      end
    end
  end
end
