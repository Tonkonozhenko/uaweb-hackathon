require 'open-uri'
require 'nokogiri'

# Returns array of semi-ready news
def parse_rss(media)
  url = media.url
  Nokogiri::XML(open(url)).css('item').map do |item|
    NewsItem.new(
        media: media,
        title: item.css('title').text,
        short_text: item.css('description').text,
        url: item.css('link').text
    )
  end
end

# Fills missing info for news
def parse_html(media, news_item)
  doc = Nokogiri::HTML(open(news_item.url))
  send("parse_#{media}", news_item, doc)
  news_item.save
end

def parse_censor(news_item, doc)
  news_item.text = doc.css('.hnews/article/.text/h2').inner_html + doc.css('.hnews/article/.text/._ga1_on_').inner_html
end

def parse_tsn(news_item, doc)
  news_item.text = doc.css('.news_text').inner_html
  news_item.image = (URI.parse(doc.css('.picture/a/img').attribute('src')) rescue nil)
end

def parse_podrobnosti(news_item, doc)
  news_item.text = doc.css('._ga1_on_/p').inner_html
end

def parse_korrespondent(news_item, doc)
  news_item.text = doc.css('.post-item__text').inner_html
  news_item.image = (URI.parse(doc.css('.post-item__photo/img').attribute('src')) rescue nil)
end

def parse_liga_news(news_item, doc)
  news_item.text = doc.css('._ga1_on_').inner_html
  news_item.image = (URI.parse('http://news.liga.net/' + doc.css('#material-image').attribute('src')) rescue nil)
end

def parse_lig_biz(news_item, doc)
  news_item.text = doc.css('._ga1_on_').inner_html
  news_item.image = (URI.parse('http://news.liga.net/' + doc.css('#material-image').attribute('src')) rescue nil)
end

namespace :parse do
  desc 'Get news from sites'
  task index: :environment do
    Media.find_each do |m|
      news_items = parse_rss(m)
      news_items.each { |news_item| parse_html(m.short_title.to_sym, news_item) }
    end
  end
end