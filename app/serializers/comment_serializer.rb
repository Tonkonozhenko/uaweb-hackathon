class CommentSerializer < ActiveModel::Serializer
  attributes :id, :text, :news_item_id
  has_one :user
end
