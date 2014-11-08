class NewsItemSerializer < ActiveModel::Serializer
  attributes :id, :title, :text, :url, :short_text, :liked, :disliked
  delegate :current_user, to: :scope

  def liked
    object.liked_by?(scope)
  end

  def disliked
    object.disliked_by?(scope)
  end
end
