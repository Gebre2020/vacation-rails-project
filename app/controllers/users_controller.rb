class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save 
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else 
            render :new
        end
    end

    def show       
        @user = User.find(params[:id])
        redirect_to '/' if !@user
    end

    private

    def user_params  # strong params
        params.require(:user).permit(:username, :email, :password)
    end

end
