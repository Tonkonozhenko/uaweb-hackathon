require 'yaml'

redis_settings = YAML::load(File.open("#{Rails.root}/config/redis.yml"))[Rails.env].symbolize_keys!

$redis = Redis.new(host: redis_settings[:host], port: redis_settings[:port], password: redis_settings[:password], database: redis_settings[:database])