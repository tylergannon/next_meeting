Geocoder.configure(
  lookup: :google,
  api_key: ENV['GOOGLE_API_SERVER_KEY'],
  timeout: 5,
  cache: Redis.new,
  cache_prefix: 'geo'
)


