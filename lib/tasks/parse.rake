require 'open-uri'
require 'nokogiri'


# Sites for parse news

# Liga.net / podrobnosti.ua / korrespondent.net / censor.net.ua
def get_news
  urls = ['http://censor.net.ua/includes/news_ru.xml', 'http://news.liga.net/all/rss.xml', 'http://biz.liga.net/all/rss.xml', 'http://ru.tsn.ua/rss/',
          'http://podrobnosti.ua/rss/', 'http://k.img.com.ua/rss/ru/all_news2.0.xml']
  urls.each do |url|
    doc_xml = Nokogiri::XML(open(url))
    items = doc_xml.css('item')
    items.each do |item|
      news = NewsItem.new
      news.title = item.css('title').text
      news.short_text = item.css('description').text
      news.url = item.css('link').text
      doc_html = Nokogiri::HTML(open(news.url))
      if url.eql? 'http://ru.tsn.ua/rss/'
        news.text = doc_html.css('.news_text').inner_html
      elsif url.eql? 'http://podrobnosti.ua/rss/'
        news.text = doc_html.css('._ga1_on_/p').inner_html
      elsif url.eql? 'http://k.img.com.ua/rss/ru/all_news2.0.xml'
        news.text = doc_html.css('.post-item__text').inner_html
      elsif url.eql? 'http://censor.net.ua/includes/news_ru.xml'
        news.text = doc_html.css('.hnews/article/.text/h2').inner_html
        news.text += doc_html.css('.hnews/article/.text/._ga1_on_').inner_html
      end
      news.save
    end
  end
end

# Returns array of semi-ready news
def parse_rss(url)

end

# Fills missing info for news
def parse_html(media, news_item)
  Thread.new do
    send("parse_#{media}", news_item)
    news_item.save
  end
end

namespace :parse do
  desc 'Get news from sites'
  task index: :environment do
    {
        censor: 'http://censor.net.ua/includes/news_ru.xml',
        liga_news: 'http://news.liga.net/all/rss.xml',
        lig_biz: 'http://biz.liga.net/all/rss.xml',
        tsn: 'http://ru.tsn.ua/rss/',
        podrobnosti: 'http://podrobnosti.ua/rss/',
        korrespondent: 'http://k.img.com.ua/rss/ru/all_news2.0.xml',
    }.each do |k, v|
      news_items = parse_rss(v)
      news_items.each { |news_item| parse_html(k, news_item) }
    end
  end
end