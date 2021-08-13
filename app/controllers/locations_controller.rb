class LocationsController < ApplicationController
    before_action :redirect_if_not_logged_in

    def index
      
      if params[:user_id] && @user = User.find_by_id(params[:user_id])
        @locations = @user.locations.all
      else
        flash[:message] = "The user doesn't exist" if params[:user_id]
        @locations = Location.all
      end
    end

    def show
      @location = Location.find_by_id(params[:id])
      redirect_to locations_path if !@location
    end

    def new
      if params[:user_id] && @user = User.find_by_id(params[:user_id])
        @location = Location.new(user_id: params[:user_id])
        #@location = Location.new  
        l = @location.trips.build
        l.build_travel
        # @location.build_user 
      else
        @error = "The user doesn't exist" if !params[:user_id]
        @location = Location.new
        @location.trips.build
        #@location.build_user
      end
    end

    def create
      @location = current_user.locations.build(location_params)
      #@location = Location.new(location_params)
      #@location.user_id = session[:user_id]
        if @location.save 
          redirect_to location_path(@location)
        else
          render :new
        end
    end

    def edit
      redirect_to locations_path if !@location || @location.user != current_user
      @location = Location.find_by_id(params[:id])
    end

    def update
      redirect_to locations_path if !@location || @location.user != current_user
      @location = Location.find_by_id(params[:id])
      @location.update(location_params)
      if @location.valid?
        redirect_to location_path(@location)
      else
        render :edit
      end
    end

    def destroy
      @location = Location.find_by_id(params[:id])
      @location.destroy 
      redirect_to locations_path
    end

  private
    def location_params
        params.require(:location).permit(:city, :country, :user_id, travel_ids:[], user_attributes:[:username], trips_attributes:[:budget, :travel_id, travels_attributes:[:name, :address]])
    end
end
