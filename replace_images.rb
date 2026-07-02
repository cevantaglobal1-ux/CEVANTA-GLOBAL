require 'json'
require 'fileutils'

log_file = '/Users/wisharahewavitharana/.gemini/antigravity/brain/ce29ea6a-060c-4b49-a6b7-bf3fa9c6f943/.system_generated/tasks/task-245.log'
# Read JSON from the log file
log_content = File.read(log_file)
# Extract json between { and }
json_str = log_content.match(/\{.*\}/m)[0]
images = JSON.parse(json_str)

mapping = {
  "heritage" => images["heritage"],
  "farmers" => images["farmers"],
  "Sri%20Lankan%20farmers" => images["farmers"],
  "cinnamon" => images["cinnamon"],
  "pepper" => images["pepper"],
  "scientist" => images["lab"],
  "manufacturing" => images["manufacturing"],
  "community" => images["community"],
  "Diamond%20engagement%20ring%20sapphire" => images["jewellery"],
  "Blue%20Sapphire" => images["blue_sapphire"],
  "Yellow%20Sapphire" => images["yellow_sapphire"],
  "Pink%20Sapphire" => images["pink_sapphire"],
  "Ruby" => images["ruby"],
  "Diamond%20engagement%20ring%20macro" => images["engagement"],
  "Sapphire%20necklace" => images["gemstone_jewel"],
  "Diamond%20tennis%20bracelet" => images["bracelet"],
  "Gold%20wedding%20bands" => images["wedding_band"],
  "Raw%20premium%20cashews" => images["cashew_raw"],
  "Roasted%20premium%20cashews" => images["cashew_roasted"],
  "Salted%20premium%20cashews" => images["cashew_salted"],
  "Flavoured" => images["cashew_flavoured"],
  "black%20tea" => images["tea_black"],
  "green%20tea" => images["tea_green"],
  "white%20tea" => images["tea_white"],
  "fruit%20tea" => images["tea_flavoured"],
  "virgin%20coconut%20oil" => images["coconut_oil"],
  "Desiccated%20coconut" => images["coconut_desiccated"],
  "Coconut%20milk" => images["coconut_milk"],
  "coconut%20water" => images["coconut_water"]
}

Dir.glob("**/*.html").each do |file|
  next if file.include?(".gemini")
  content = File.read(file)
  new_content = content.gsub(/https:\/\/image\.pollinations\.ai\/prompt\/([^\?"]+)\?[^"]+/) do |match|
    prompt = $1
    replacement = match
    mapping.each do |key, url|
      if prompt.include?(key)
        replacement = url
        break
      end
    end
    replacement
  end
  if content != new_content
    File.write(file, new_content)
    puts "Updated #{file}"
  end
end
