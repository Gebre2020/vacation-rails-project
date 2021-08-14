class ApplicationController < ActionController::Base

    include ApplicationHelper 
    # gives access to methods in the views
    # helper_method :current_user, :logged_in?

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    
    private
    # def current_user
    #     @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    # end

    # def logged_in?
    #    !!current_user
    #    # session[:user_id]
    # end

    def redirect_if_not_logged_in?
        redirect_to login_path if !logged_in?
    end

    def record_not_found(error)
        #byebug
        @message = error.message
        # render :"layouts/error_page"
        redirect_to :root, notice: "Page Not Found: #{@message}"
    end
end
