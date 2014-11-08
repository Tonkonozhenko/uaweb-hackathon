require 'redis'
require 'json'
require 'yaml'
require 'active_support/core_ext/hash/keys'

require 'eventmachine'
require 'em-websocket'

env = 'development'
redis_settings = YAML::load(File.open("#{File.expand_path __dir__ + '/..'}/config/redis.yml"))[env].symbolize_keys!
$redis = Redis.new(host: redis_settings[:host], port: redis_settings[:port], password: redis_settings[:password], database: redis_settings[:database])

chanel_name = 'ngnews'
clients = []

redis_thread = Thread.new do
  $redis.subscribe chanel_name do |on|
    on.message do |_, msg|
      clients.each { |ws| ws.send msg }
    end
  end
end

EM.run do
  EM::WebSocket.start(host: '127.0.0.1', port: 3333) do |ws|
    ws.onopen { clients << ws }
    ws.onclose { clients.delete ws }
  end
end