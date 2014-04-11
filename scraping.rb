# -- coding: utf-8

require "open-uri"
require "rubygems"
require "nokogiri"
require "csv"

url_list = [
	#chemical
	"http://jpdb.nihs.go.jp/jp/DetailList_ja.aspx?type=cmc&keyword=&submit=%E5%85%A8%E9%A0%85%E7%9B%AE%E8%A1%A8%E7%A4%BA%EF%BC%88%E3%81%82%E3%81%84%E3%81%86%E3%81%88%E3%81%8A%E9%A0%86%EF%BC%89%E8%A1%A8%E7%A4%BA%E3%81%AB%E6%99%82%E9%96%93%E3%81%8C%E3%81%8B%E3%81%8B%E3%82%8A%E3%81%BE%E3%81%99",
	
	#herbal
	"http://jpdb.nihs.go.jp/jp/DetailList_ja.aspx?type=pmc&keyword=&submit=%E5%85%A8%E9%A0%85%E7%9B%AE%E8%A1%A8%E7%A4%BA%EF%BC%88%E3%81%82%E3%81%84%E3%81%86%E3%81%88%E3%81%8A%E9%A0%86%EF%BC%89%E8%A1%A8%E7%A4%BA%E3%81%AB%E6%99%82%E9%96%93%E3%81%8C%E3%81%8B%E3%81%8B%E3%82%8A%E3%81%BE%E3%81%99"	
]

urls.each do |url|
	CSV.open("./output.csv","w") do |csv_writer|
		html = open(url) do |f|
			charset = f.charset
			f.read
		end
		doc = Nokogiri::HTML.parse(html, nil, charset)	

		# get drug name
		doc.xpath('//td').each do |node|
			name = node.xpath('span[@style="font-weight: bold;"]').text
			if(name != "")
				csv_writer << [name]
			end
		end
	end
end