class CategoryNewsItem < ActiveRecord::Base
  belongs_to :category
  belongs_to :news_item
end
