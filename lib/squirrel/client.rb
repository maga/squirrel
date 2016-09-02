module Squirrel
  module Client
    OPTIONS = { namespace: "app_v1", compress: true }

    def client
      Dalli::Client.new("localhost:11211", OPTIONS)
    end
  end
end
