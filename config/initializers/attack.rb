# Block requests for php or cgi
Rack::Attack.blacklist('block 1.2.3.4') do |req|
  # Request are blocked if the return value is truthy
  req.path.index("php") || req.path.index("cgi") || req.path.index("proxy.txt") || req.path.index("soapCaller")
end

# Throttle requests to 5 requests per second per ip
Rack::Attack.throttle('req/ip', :limit => 5, :period => 1.second) do |req|
  # If the return value is truthy, the cache key for the return value
  # is incremented and compared with the limit. In this case:
  #   "rack::attack:#{Time.now.to_i/1.second}:req/ip:#{req.ip}"
  #
  # If falsy, the cache key is neither incremented nor checked.

  req.ip
end

# Always allow requests from shop
# (blacklist & throttles are skipped)
Rack::Attack.whitelist('allow from localhost') do |req|
  # Requests are allowed if the return value is truthy
   [ '85.76.176.10' , "85.76.168.133" , "127.0.0.1"].include? req.ip
end
