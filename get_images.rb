require 'net/http'
require 'json'
require 'cgi'

queries = [
  "sri-lanka-tea", "cashew", "sapphire", "laboratory-scientist", "engagement-ring", "cinnamon"
]

results = {}

queries.each do |q|
  url = URI("https://unsplash.com/s/photos/#{q}")
  req = Net::HTTP::Get.new(url)
  req['User-Agent'] = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36'
  res = Net::HTTP.start(url.hostname, url.port, use_ssl: true) { |http| http.request(req) }
  
  if res.body =~ /"(https:\/\/images\.unsplash\.com\/photo-[a-zA-Z0-9\-]+)\?/
    results[q] = $1 + "?auto=format&fit=crop&w=800&q=80"
  else
    results[q] = "Not found"
  end
end

puts JSON.pretty_generate(results)
