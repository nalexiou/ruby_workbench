require "json"

data = JSON.parse(colors.json)
data['colorsArray'].each do |item|
    puts item['colorName']
    puts item['hexValue']
end
