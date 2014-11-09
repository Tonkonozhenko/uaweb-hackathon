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
  belongs_to :media

  has_attached_file :image, styles: { big: '480x270>', medium: '320x240>', thumb: '160x180>' }
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  # :default_url => "/no_avatar.gif"
  # do_not_validate_attachment_file_type :image


  validates_presence_of :title, :text, :url

  after_create { $redis.publish 'ngnews', NewsItemSerializer.new(self).to_json }

  before_save { media.touch if rating_changed? }

  has_many :comments

  scope :by_category, -> (category_ids) { joins(:category_news_items).where(category_news_items: { category_id: category_ids }) }

  validates_presence_of :title, :text, :url

  def plus!(id)
    plus_ids << id
    plus_ids_will_change!
    self.plus_count += 1
    calculate_rating!
    save
  end

  def minus!(id)
    minus_ids << id
    minus_ids_will_change!
    self.minus_count += 1
    calculate_rating!
    save
  end

  def liked_by?(user)
    id = user.is_a?(User) ? user.id : user
    !(plus_ids.index(id).nil?)
  end

  def disliked_by?(user)
    id = user.is_a?(User) ? user.id : user
    !minus_ids.index(id).nil?
  end

  def calculate_rating!
    self.rating = wilson_score
  end

  # http://habrahabr.ru/company/darudar/blog/143188/
  def wilson_score
    up = plus_count
    down = minus_count
    return -down unless up
    n = plus_count + minus_count
    z = 1.64485
    phat = up.to_f / n
    (phat + z * z / (2 * n) - z * Math.sqrt((phat * (1 - phat) + z * z / (4 * n)) / n))/(1 + z * z / n)
  end
end
