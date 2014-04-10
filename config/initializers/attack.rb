# Block requests for php or cgi, jps and what else the people throw at us
Rack::Attack.blacklist('block admin probes') do |req|
  # Request are blocked if the return value is truthy
  ["php" , "jsp" , "cgi", "asp", "cfm," "proxy.txt", "soapCaller", "Win32" , "HNAP1" , "w00tw00t",
    "pma" , "mysql" ,"msd" , "MySQL" , "jmx-console" , "ervlet" , "install"].each do |no|
    return true if  req.path.index(no)
  end
  false
end

# Block requests from people clearly out to break servers
Rack::Attack.blacklist('block admin probes') do |req|
  [ "79.143.82.69" , "85.76.99.50", "127.0.0.1"].include? req.ip
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
   [ "85.76.112.161" , "85.76.99.50", "127.0.0.1"].include? req.ip
end
