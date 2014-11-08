class Category < ActiveRecord::Base
  has_many :category_news_items
  has_many :news_items, through: :category_news_items
end
