ShortUrl.config do |config|
  config.redis     = Redis.new
  config.token_key = 'life-bills'
  config.type      = :md5  
end