module Squirrel
  module FileManager
    class FileCapsuleSaver < FileCapsule
      def save
        (raise "No such file #{filename}" and return) unless exists?

        save_chunks
        save_keys
      end

      private

      def exists?
        ::File.file?(filename)
      end

      def save_chunks
        chunks.each do |key, chunk|
          MemcachedClient.set(key, chunk)
        end
      end

      def save_keys
        MemcachedClient.set(basename, chunks_keys)
      end

      def chunks
        ::File.open(filename) do |fh_in|
          chunks_keys.each_with_object({}) do |key, hash|
            hash["#{key}"] = fh_in.read(CHUNK_SIZE)
          end
        end
      end

      def specify_keys
        return unless exists?

        number_of_chunks.times.map { |i| "#{basename}_#{i}" }
      end

      def number_of_chunks
        (file.size / CHUNK_SIZE).ceil
      end

      def file
        ::File.open(filename)
      end
    end
  end
end
