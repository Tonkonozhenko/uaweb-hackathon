require 'open-uri'
require 'nokogiri'


# Sites for parse news

# Liga.net
def get_news_from_liga_net
  news = NewsItem.new

  doc_XML = Nokogiri::XML(open('http://news.liga.net/all/rss.xml'))
  items = doc_XML.css('item')
  items.each do |item|
    title = item.css('title')
    description = item.css('description')
    link = item.css('link')
    # item_link = Nokogiri::HTML(open(link))
  end


  1.to_s
end

namespace :parse do
  desc 'Get news from sites'
  task index: :environment do

    get_news_from_liga_net
    puts 'Hello world'
  end
end