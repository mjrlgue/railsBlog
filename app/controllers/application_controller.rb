class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  #confirms a logged_in_user
    def logged_in_user
    unless  logged_in?
      #save the URL that a user want go in
      store_location
      flash[:danger] = "Veuillez vous authentifiez !"
      redirect_to login_url
    end
  end
end
