require "forwardable"

module Squirrel
  module FileManager
    class FileCapsule
      include MemcachedClient

      CHUNK_SIZE = 1024000.0

      attr_reader :filename, :basename, :chunks_keys

      def initialize(options)
        @filename    = options[:filename]
        @basename    = set_basename
        @chunks_keys = specify_keys
      end

      private

      def set_basename
        ::File.basename(filename)
      end

      def exists?
        true
      end

      def specify_keys
        []
      end
    end
  end
end
