class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  def token

  end

  def _current_user
    render user_signed_in? ? { json: current_user, serializer: CurrentUserSerializer } : { json: {}, status: :forbidden }
  end
end
