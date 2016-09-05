require "dalli"

module Squirrel
  module MemcachedClient
    OPTIONS = { namespace: "app_v1", compress: true }
    CLIENT  = Dalli::Client.new("localhost:11211", OPTIONS)

    def set(key, value)
      CLIENT.set(key, value)
    end

    def get(key)
      CLIENT.get(key)
    end

    def get_multi(key)
      CLIENT.get_multi(key)
    end

    def delete(key)
      CLIENT.delete(key)
    end

    module_function :set, :get, :get_multi, :delete
  end
end
