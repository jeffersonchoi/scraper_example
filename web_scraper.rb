require 'HTTParty'
require 'Nokogiri'
require 'Pry'
require 'csv'

page = HTTParty.get('https://www.prada.com/us/en/search.bag.html')

parse_page = Nokogiri::HTML(page)

bags_array = []

parse_page.css('.wrapper').map do |item|
	hash = {}
	hash["item_name"] = item.css('.description').first.children[1].children[0].text
	hash["item_price"] = item.css('.description').first.children[3].children[0].text
	hash["item_pic"] = item.css('.product-link').first.children[1].attributes.first[1].value
	bags_array << hash unless bags_array.include? hash
end

puts bags_array
