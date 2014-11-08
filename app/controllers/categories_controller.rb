class CategoriesController < ApplicationController
  inherit_resources
  actions :index
  respond_to :json
end
