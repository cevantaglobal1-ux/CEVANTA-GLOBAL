require 'net/http'
require 'json'
require 'uri'

def search(query)
  url = URI("https://commons.wikimedia.org/w/api.php?action=query&generator=search&gsrsearch=#{URI.encode_www_form_component(query)}&gsrnamespace=6&gsrlimit=3&prop=imageinfo&iiprop=url&format=json")
  response = Net::HTTP.get(url)
  data = JSON.parse(response)
  pages = data.dig('query', 'pages') || {}
  pages.values.map { |p| p.dig('imageinfo', 0, 'url') }
end

puts "Roasted cashews:"
puts search('roasted cashews')
puts "Salted cashews:"
puts search('salted cashews')
puts "Flavoured cashews:"
puts search('flavoured cashews')
