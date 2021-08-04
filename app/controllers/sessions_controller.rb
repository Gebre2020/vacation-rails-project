class SessionsController < ApplicationController
 
    # def welcome
    # end
    
    # def new    
    # end

    def create 
        # byebug
        # @person && @person.name
        # @person.try(:name)
        user = User.find_by(username: params[:user][:username])
        if user && user.authenticate(params[:user][:password])
        # if user.try(:authenticate, params[:user][:password])   
            session[:user_id] = user.id
            redirect_to locations_path
        else
            flash[:message] = "Invalid credentials. Please try again. "
            redirect_to login_path
        end
    end

    def omniauth
        # User.find_or_create_by(name: params["name"])
        # user = User.from_omniauth(auth)
        user = User.find_or_create_by(uid: auth['uid'], provider: auth['provider']) do |u|
            u.email = auth['info']['email']
            u.username = auth['info']['name']
            u.password = SecureRandom.hex(15)
        end
        if user.valid? 
          session[:user_id] = user.id
          flash[:message] = "Successful Google Login!!"
          redirect_to user_path(user)
        else
           redirect_to login_path
        end
        
       
    end

    def destroy
        session.delete(:user_id)
        redirect_to locations_path
    end

    private

    def auth 
     request.env['omniauth.auth']
    end
    
end