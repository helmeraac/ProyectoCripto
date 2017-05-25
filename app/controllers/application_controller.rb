class ApplicationController < ActionController::Base

  # protect_from_forgery with: :exception
  def redirect_user
    redirect_to '/404'
  end
end
