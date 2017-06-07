class SessionsController < ApplicationController
  
  def new
  end

#create session ressoruces
  def create
  	user = User.find_by(email: params[:session][:email])
  	if user && user.authenticate(params[:session][:password])
      log_in user
      if params[:session][:remember_me] == '1'
        remember user
      else
        forget user
      end
      redirect_to user
      flash[:success] = "Welcome dear user !"
  		#log in user and redirect to user's show(profile) page

  	else
  		#create an error message
  		flash.now[:danger]  = "Invalid email/password combination ! try again."
  	render 'new'
  end
  end

  def destroy 
    log_out if logged_in?
    flash[:success] = "Vous êtes déconnecté !"
    redirect_to root_url
  end

end
