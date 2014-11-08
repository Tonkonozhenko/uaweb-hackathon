class NewsItemSerializer < ActiveModel::Serializer
  attributes :id, :title, :text, :url, :short_text, :liked, :disliked, :image_url
  delegate :current_user, to: :scope

  def liked
    object.liked_by?(scope)
  end

  def disliked
    object.disliked_by?(scope)
  end

  def image_url
    object.image.url(:big) rescue nil
  end
end
