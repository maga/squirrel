require "forwardable"

module Squirrel
  class FileCapsule
    extend Forwardable
    def_delegator :@chunks, :each, :each_chunk

    include Enumerable

    CHUNK_SIZE = 1024000.0

    attr_reader :filename, :basename, :chunks_keys

    def initialize(options)
      @filename = options[:filename]
      @basename = get_basename

      return unless exists?

      @chunks_keys = get_keys
      @chunks = get_chunks if exists?
    end

    # TODO: Handle Errno::ENOENT: No such file or directory
    # for unexisted file
    def exists?
      File.file?(filename)
    end

    private

    def get_chunks
      File.open(filename) do |fh_in|
        chunks_keys.each_with_object({}) do |key, hash|
          hash["#{key}"] = fh_in.read(CHUNK_SIZE)
        end
      end
    end

    def get_keys
      number_of_chunks.times.map { |i| "#{basename}_#{i}" }
    end

    def number_of_chunks
      (file.size / CHUNK_SIZE).ceil
    end

    def file
      File.open(filename)
    end

    def get_basename
      File.basename(filename)
    end
  end
end
