# == Schema Information
#
# Table name: category_news_items
#
#  id           :integer          not null, primary key
#  category_id  :integer
#  news_item_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class CategoryNewsItem < ActiveRecord::Base
  belongs_to :category
  belongs_to :news_item
end
