require 'net/http'
require 'json'

queries = {
  "heritage" => "Sigiriya",
  "farmers" => "Tea plucker Sri Lanka",
  "cinnamon" => "Cinnamon sticks",
  "pepper" => "Black pepper",
  "lab" => "Laboratory scientist",
  "manufacturing" => "Manufacturing plant",
  "community" => "Sri Lanka village",
  "jewellery" => "Diamond ring",
  "blue_sapphire" => "Blue sapphire",
  "yellow_sapphire" => "Yellow sapphire",
  "pink_sapphire" => "Pink sapphire",
  "ruby" => "Ruby gemstone",
  "engagement" => "Engagement ring",
  "gemstone_jewel" => "Gemstone necklace",
  "bracelet" => "Diamond bracelet",
  "wedding_band" => "Wedding band ring",
  "cashew_raw" => "Raw cashew nut",
  "cashew_roasted" => "Roasted cashews",
  "cashew_salted" => "Salted cashews",
  "cashew_flavoured" => "Spicy cashews",
  "tea_black" => "Black tea cup",
  "tea_green" => "Green tea cup",
  "tea_white" => "White tea leaves",
  "tea_flavoured" => "Fruit tea cup",
  "coconut_oil" => "Coconut oil jar",
  "coconut_desiccated" => "Desiccated coconut",
  "coconut_milk" => "Coconut milk",
  "coconut_water" => "Coconut water drink"
}

results = {}

queries.each do |key, q|
  url = URI("https://en.wikipedia.org/w/api.php?action=query&format=json&prop=pageimages&generator=search&gsrsearch=#{URI.encode_www_form_component(q)}&gsrnamespace=0|6&pithumbsize=800&gsrlimit=1")
  req = Net::HTTP::Get.new(url)
  req['User-Agent'] = 'Cevanta/1.0 (test@example.com)'
  res = Net::HTTP.start(url.hostname, url.port, use_ssl: true) { |http| http.request(req) }
  
  begin
    data = JSON.parse(res.body)
    pages = data['query']['pages']
    first_page = pages.values.first
    if first_page && first_page['thumbnail']
      results[key] = first_page['thumbnail']['source']
    else
      results[key] = "https://picsum.photos/seed/#{key}/800/600"
    end
  rescue
    results[key] = "https://picsum.photos/seed/#{key}/800/600"
  end
end

puts JSON.pretty_generate(results)
