class MediaSerializer < ActiveModel::Serializer
  attributes :id, :title, :short_title, :url, :rating
end
