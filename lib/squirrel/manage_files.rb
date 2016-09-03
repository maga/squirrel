require "dalli"

module Squirrel
  class ManageFiles
    attr_reader :files

    def initialize(options)
      @files = FilesFactory.build(filenames: options[:filenames])

      post_initialize
    end

    def post_initialize
    end
  end
end
