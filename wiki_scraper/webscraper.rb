require 'rubygems'
require 'nokogiri'
require 'open-uri'

BASE_WIKIPEDIA_URL = "http://en.wikipedia.org"
AWARDS_URL = "#{BASE_WIKIPEDIA_URL}/wiki/Academy_Award_for_Best_Picture"

File.open("output.txt", 'w') do |file| 
	page = Nokogiri::HTML(open(AWARDS_URL))

	rows = page.css("div.mw-content-ltr table.wikitable tr:eq(2)") 

	puts rows.class
	budget_total = 0
	budget_count = 0
	rows.each do |row|
		 hrefs = row.css("td:eq(1) a[href^='/wiki']").map {|a|
		 	a['href'] if a['href'].match("/wiki")
		 }.uniq
		 hrefs.each do |href|
		 	remoteurl = BASE_WIKIPEDIA_URL + href
		 	wiki_film_page = Nokogiri::HTML(open(remoteurl))

		 	#----Title extraction----
		 	title = wiki_film_page.css('table.infobox th.summary').first.text.strip.gsub("\n"," ")
		 	
		 	#----Film Release year extraction----
		 	release_date_data = wiki_film_page.css('table.infobox tr:contains("Release dates") td').text.strip
		 	release_year_match = release_date_data.match(/\d{4}/)
		 	if !release_year_match.nil? then
		 		release_year = release_year_match[0]
		 	else
		 		release_year = row.ancestors("table").first.css("caption big").text
		 	end

		 	#----Budget extraction----
		 	budget = wiki_film_page.css('table.infobox tr:contains("Budget") td').text.strip.gsub(/\[.\]/,'')
		 	budget = "Not Available" if budget ==""

		 	budget_usdollars_match = budget.match(/\$([\d,.]+)(?:[\–\-])?(\d)?\s?(million)?/i)

		 	if !budget_usdollars_match.nil?
		 		if budget_usdollars_match[3].nil?
		 			budget_total += budget_usdollars_match[1].gsub(/[^\d^\.]/, '').to_f
		 		else
		 			if budget_usdollars_match[2].nil?
		 				budget_total += (budget_usdollars_match[1].to_f * 1000000) if budget_usdollars_match[3].downcase == "million"
		 			
		 			else
		 				range_avg = (budget_usdollars_match[2].to_f + budget_usdollars_match[1].to_f)/2
		 				budget_total += (range_avg * 1000000) if budget_usdollars_match[3].downcase == "million"
		 			end
		 		end
				budget_count += 1
		 	end

		 	p "Year: #{release_year} | Title: #{title} | Budget: #{budget}"
		 	file.write("Year: #{release_year} | Title: #{title} | Budget: #{budget}\n")
		 end
	end
		average_budget = (budget_total / budget_count).round
		average_budget = average_budget.to_s.reverse.scan(/\d{3}|.+/).join(",").reverse
	file.write("Average budget: $#{average_budget}\n")
end
