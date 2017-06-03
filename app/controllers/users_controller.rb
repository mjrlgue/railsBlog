class UsersController < ApplicationController
  
  def show
  	#show user with param given with the url
  	@user = User.find(params[:id])
  	#debugger : for debug
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		flash[:success] = "Bonjour au site e-Learn !"
  		redirect_to @user
  		#save the user
  	else
  		render 'new'
  	end
  end
end

private
#permit some attributes for security reason
#called strong parameter
	def user_params
	  params.require(:user).permit(:name, :email, :password,:password_confirmation)	
	end

