require "forwardable"

module Squirrel
  class FileCapsule
    extend Forwardable
    def_delegators :@chunks, :each, :keys

    include Enumerable

    attr_reader :filename, :basename, :chunks

    def initialize(options)
      @filename = options[:filename]
      @basename = get_basename
      @chunks = get_chunks(options[:chunk_size])
    end

    # TODO: refactor like (0..file.size / chunk_size).inject({})
    def get_chunks(chunk_size)
      i = 0
      hash = {}

      File.open(filename, "r") do |fh_in|
        until fh_in.eof?
          hash["#{basename}_#{i}"] = fh_in.read(chunk_size)
          i += 1
        end
      end

      hash
    end

    private

    # TODO: Errno::ENOENT: No such file or directory Handler
    def open_file(filename)
      File.open(filename, "r")
    end

    def get_basename
      File.basename(filename)
    end
  end
end
