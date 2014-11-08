# == Schema Information
#
# Table name: news_items
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  text        :text
#  rating      :float            default(0.0)
#  plus_ids    :integer          is an Array
#  minus_ids   :integer          is an Array
#  plus_count  :integer          default(0)
#  minus_count :integer          default(0)
#  created_at  :datetime
#  updated_at  :datetime
#

class NewsItem < ActiveRecord::Base
  has_many :category_news_items
  has_many :categories, through: :category_news_items
end
