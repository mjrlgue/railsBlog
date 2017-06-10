module SessionsHelper

    #log in the given user
    def log_in(user)
        session[:user_id] = user.id
    end

    #remember a user
    def remember(user)
      user.remember
      #save the cookie and encrypt it with signed
      cookies.permanent.signed[:user_id]     = user.id #same as: { value: user.id, 
                                                                                                  #expires: 20.years.from_now.utc}
      #store the cookie as a 'password'
      cookies.permanent[:remember_token] = user.remember_token
    end

    #returns true, if the given user is the current user
    def current_user?(user)
      user == current_user
    end

    #returns the current logged-in user
    def current_user
      #when the session is there
      if (user_id = session[:user_id])
        @current_user ||= User.find_by(id: user_id)
      #test on the cookie
      elsif (user_id = cookies.signed[:user_id])
        user = User.find_by(id: user_id )
        if user && user.authenticated?(cookies[:remember_token])
          log_in user
          @current_user = user
        end
      end
    end

    #returns true if the user is loged in, else false
    def logged_in?
        !current_user.nil?
    end

    #forget a session using cookies
    def forget(user)
      user.forget
      cookies.delete(:user_id)
      cookies.delete(:remember_token)
    end
    #Logs out the current user
    def log_out
      forget(current_user)
      session.delete(:user_id) #or session[:user_id] = nil
      #set current_user to nil for security reason
      @current_user = nil
    end

    #redirect to stored location or default
    def redirect_back_or(default)
      redirect_to(session[:forwarding_url] || default)
      session.delete(:forwarding_url)
    end

    #store the URL trying to be accessed
    def store_location
      session[:forwarding_url] = request.url if request.get?
    end
end
