class LocationsController < ApplicationController
    before_action :redirect_if_not_logged_in

    def index
      @locations = Location.all
    end

    def show
      @location = Location.find_by_id(params[:id])
    end

    def new
        @location = Location.new
    end

    def create
        @location = current_user.locations.build(location_params)
        #binding.pry
        if @location.save 
          redirect_to locations_path
        else
          render :new
        end
    end

    def edit
      @location = Location.find_by_id(params[:id])
    end

    def update
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
        params.require(:location).permit(:city, :country)
    end
end
