class MediasController < ApplicationController
  inherit_resources
  actions :index
  respond_to :json
end
