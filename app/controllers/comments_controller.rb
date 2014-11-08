class CommentsController < ApplicationController
  inherit_resources
  actions :index, :create
  belongs_to :news_item
  respond_to :json
  before_filter :authenticate_user!, only: [:create]

  def create
    @comment = current_user.comments.build(permitted_params[:comment])
    @comment.news_item_id = params[:news_item_id]
    create!
  end

  protected
  def collection
    @comments ||= end_of_association_chain.includes(:user)
  end

  def permitted_params
    params.permit(comment: [:text])
  end
end
