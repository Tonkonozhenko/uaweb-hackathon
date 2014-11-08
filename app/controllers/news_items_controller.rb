class NewsItemsController < ApplicationController
  inherit_resources
  actions :index, :show
  respond_to :json, :html
  has_scope :by_category, type: :array

  before_filter :authenticate_user!, only: [:like, :dislike]

  def like
    ok =
        if resource.liked_by?(current_user) || resource.disliked_by?(current_user)
          false
        else
          resource.plus!(current_user.id)
        end
    render json: { ok: ok }, status: ok ? :ok : :forbidden
  end

  def dislike
    ok =
        if resource.liked_by?(current_user) || resource.disliked_by?(current_user)
          false
        else
          resource.minus!(current_user.id)
        end
    render json: { ok: ok }, status: ok ? :ok : :forbidden
  end

  protected
  def collection
    @news_items ||= end_of_association_chain.order('rating DESC').page(params[:page]).per(50)
  end
end
