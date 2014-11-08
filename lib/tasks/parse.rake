require 'open-uri'
require 'nokogiri'


# Sites for parse news

# Liga.net / podrobnosti.ua / korrespondent.net /
def get_news
  urls = ['http://news.liga.net/all/rss.xml', 'http://biz.liga.net/all/rss.xml', 'http://ru.tsn.ua/rss/',
          'http://podrobnosti.ua/rss/', 'http://k.img.com.ua/rss/ru/all_news2.0.xml']
  urls.each do |url|
    doc_XML = Nokogiri::XML(open(url))
    items = doc_XML.css('item')
    items.each do |item|
      news = NewsItem.new
      news.title = item.css('title').text
      news.short_text = item.css('description').text
      news.url = item.css('link').text
      doc_HTML = Nokogiri::HTML(open(news.url))
      if url.eql? 'http://ru.tsn.ua/rss/'
        news.text = doc_HTML.css('.news_text').inner_html
      elsif url.eql? 'http://podrobnosti.ua/rss/'
        news.text = doc_HTML.css('._ga1_on_/p').inner_html
      elsif url.eql? 'http://k.img.com.ua/rss/ru/all_news2.0.xml'
        news.text = doc_HTML.css('.post-item__text').inner_html
      end
      news.save
    end
  end
end

# korespondent.ua
# def get_news_from_podrobnosti_ua
#   doc_XML = Nokogiri::XML(open('http://k.img.com.ua/rss/ru/all_news2.0.xml'))
#   items = doc_XML.css('item')
#   items.each do |item|
#     news = NewsItem.new
#     news.title = item.css('title').text
#     news.short_text = item.css('description').text
#     news.url = item.css('link').text
#     doc_HTML = Nokogiri::HTML(open(news.url))
#     news.text = doc_HTML.css('.post-item__text').inner_html
#     news.save
#   end
# end

# TSN.ua
# def get_news_from_tsn_ua
#   doc_XML = Nokogiri::XML(open('http://ru.tsn.ua/rss/'))
#   items = doc_XML.css('item')
#   items.each do |item|
#     news = NewsItem.new
#     news.title = item.css('title').text
#     news.short_text = item.css('description').text
#     news.url = item.css('link').text
#     doc_HTML = Nokogiri::HTML(open(news.url))
#     news.text = doc_HTML.css('.news_text').inner_html
#     news.save
#   end


namespace :parse do
  desc 'Get news from sites'
  task index: :environment do

    get_news

    puts 'Hello world'
  end
end