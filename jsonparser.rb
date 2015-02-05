require "json"
file = File.read('colors.json')
data = JSON.parse(file)
data['colorsArray'].each do |item|
    puts item['colorName']
    puts item['hexValue']
end
