class NewsItemsController < ApplicationController
  inherit_resources
  actions :index, :show
  respond_to :json, :html
end
