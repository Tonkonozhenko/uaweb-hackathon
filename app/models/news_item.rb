class NewsItem < ActiveRecord::Base
  has_many :category_news_items
  has_many :categories, through: :category_news_items
end
