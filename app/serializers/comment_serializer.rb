class CommentSerializer < ActiveModel::Serializer
  attributes :id, :text, :news_item_id, :created_at
  has_one :user
end
