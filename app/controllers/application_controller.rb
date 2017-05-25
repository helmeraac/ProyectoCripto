class ApplicationController < ActionController::Base
  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end
  # protect_from_forgery with: :exception
  def redirect_user
    redirect_to '/404'
  end
end
