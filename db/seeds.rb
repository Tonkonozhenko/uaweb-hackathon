# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
[
    # ['Цензор', :censor, 'http://censor.net.ua/includes/news_ru.xml'],
    ['Лига новости', :liga_news, 'http://news.liga.net/all/rss.xml'],
    ['Лига бизнес', :lig_biz, 'http://biz.liga.net/all/rss.xml'],
    # ['ТСН', :tsn, 'http://ru.tsn.ua/rss/'],
    # ['Подробности', :podrobnosti, 'http://podrobnosti.ua/rss/'],
    # ['Корреспондент', :korrespondent, 'http://k.img.com.ua/rss/ru/all_news2.0.xml'],
].each do |k|
  Media.create(
      title: k[0],
      short_title: k[1],
      url: k[2]
  )
end