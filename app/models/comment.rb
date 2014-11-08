class Comment < ActiveRecord::Base
  belongs_to :news_item
  belongs_to :user

  validates_presence_of :news_item
end
