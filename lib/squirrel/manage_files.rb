require "dalli"

module Squirrel
  class ManageFiles
    attr_reader :filenames

    def initialize(options)
      @filenames  = options[:filenames]

      post_initialize
    end

    def post_initialize
    end
  end
end
