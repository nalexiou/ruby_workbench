require 'mechanize'

mechanize = Mechanize.new

page = mechanize.get('https://www.samplesite.com/web/en-US/apps/account/account.aspx')

signin_form = page.form_with :name => "aspnetForm"
signin_form.field_with(:name => "fieldname1").value = "sample1"
signin_form.field_with(:name => "fieldname2").value = "sampl2"

signin_results = signin_form.submit( signin_form.button_with(:value => "Sign In (Secure)") )


searcharray = []

searcharray << ["eee","","02/25/2015","04/04/2015","1234"]
searcharray << ["wer","rew","02/19/2015","04/04/2015","1234"]

searcharray.each do |x|

	origin = x[0]
	destination = x[1]
	depdate = x[2]
	retdate = x[3]
	flight = x[4]

	page = mechanize.get('http://www.samplesite.com/web/en-US/Default.aspx')
	search_form = page.form_with :name => "aspnetForm"
	search_form.field_with(:name => "field1").value = origin
	search_form.field_with(:name => "field2").value = destination
	search_form.field_with(:name => "field3").value = depdate
	search_form.field_with(:name => "field4").value = retdate
	search_results = search_form.submit( search_form.button_with(:name => "clickbuttonname") )

	matchedtext= search_results.search('//b[contains(text(),"XX'+flight+'")]/../following-sibling::span//div//*[contains(text(),"Sample")]/../text()[2]').text
end

