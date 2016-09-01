require "forwardable"

module Squirrel
  class FileCapsule
    extend Forwardable
    def_delegators :@chunks, :each, :keys

    include Enumerable

    CHUNK_SIZE = 1024000.0

    attr_reader :filename, :basename

    def initialize(options)
      @filename = options[:filename]

      return unless exists?

      @basename = get_basename
      @chunks = get_chunks
    end

    # TODO: Handle Errno::ENOENT: No such file or directory
    # for unexisted file
    def exists?
      File.file?(filename)
    end

    private

    def get_chunks(chunk_size = CHUNK_SIZE)
      File.open(filename) do |fh_in|
        number_of_chunks.times.with_object({}) do |i, hash|
          hash["#{basename}_#{i}"] = fh_in.read(chunk_size)
        end
      end
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
