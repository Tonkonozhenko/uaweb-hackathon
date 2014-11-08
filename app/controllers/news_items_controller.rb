class NewsItemsController < ApplicationController
  inherit_resources
  actions :index, :show
  respond_to :json, :html

  before_filter :authenticate_user!, only: [:like, :dislike]

  def like
    ok =
        if resource.liked_by?(current_user) || resource.disliked_by?(current_user)
          false
        else
          resource.plus!(current_user_id)
        end
    render json: { ok: ok }, status: ok ? :ok : :forbidden
  end

  def dislike
    current_user_id = current_user.id

    ok =
        if resource.plus_ids.index(current_user_id).nil? && resource.minus_ids.index(current_user_id).nil?
          resource.minus!(current_user_id)
        end
    render json: { ok: ok }, status: ok ? :ok : :forbidden
  end
end
