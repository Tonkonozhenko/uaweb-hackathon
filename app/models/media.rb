class Media < ActiveRecord::Base
  has_many :news_items

  def calculate_rating!
    self.rating = wilson_score
    puts "saved? => #{save}"
  end

  # http://habrahabr.ru/company/darudar/blog/143188/
  def wilson_score
    ratings = news_items.pluck(:rating)
    up = ratings.inject(&:+)
    down = 0
    return -down unless up
    n = ratings.length
    z = 1.64485
    phat = up.to_f / n
    (phat + z * z / (2 * n) - z * Math.sqrt((phat * (1 - phat) + z * z / (4 * n)) / n))/(1 + z * z / n)
  end
end
