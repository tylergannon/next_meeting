options = {
  lookup: :google,
  api_key: ENV['GOOGLE_API_SERVER_KEY'],
  timeout: 5
}

unless Rails.env.test?
  options[:cache] = Redis.new
  options[:cache_prefix] = 'geo'
end

Geocoder.configure options


