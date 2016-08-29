require "dalli"

module Squirrel
  class ManageFiles
    # TODO: move CHUNK size to config
    CHUNK_SIZE = 1024000

    # TODO: move dalli interface to the end class(FileCacher)
    OPTIONS = { namespace: "app_v1", compress: true }

    attr_reader :filenames, :chunk_size, :dalli_client

    def initialize(options)
      @filenames  = options[:filenames]
      @chunk_size = options.fetch(:chunk_size, CHUNK_SIZE)
      @dalli_client = Dalli::Client.new("localhost:11211", OPTIONS)

      post_initialize
    end

    def post_initialize
    end
  end
end
