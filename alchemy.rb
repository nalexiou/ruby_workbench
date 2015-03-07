require 'alchemy_api'

AlchemyAPI.key = ENV["alchemy_key"]

p results = AlchemyAPI.search(:keyword_extraction, text: "hello world this is my first alchemy test")
p results = AlchemyAPI::EntityExtraction.new.search(url: 'http://www.alchemyapi.com/')
p results = AlchemyAPI::ConceptTagging.new.search(url: 'http://www.alchemyapi.com/')



