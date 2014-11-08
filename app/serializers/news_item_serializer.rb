class NewsItemSerializer < ActiveModel::Serializer
  attributes :id, :title, :text, :url
end
