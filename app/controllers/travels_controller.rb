class TravelsController < ApplicationController

  before_action :redirect_if_not_logged_in?
  before_action :find_travel, only: [:show, :update, :edit, :destroy]

    def index
        @travels = Travel.order_by_name.uniq
    end

    def show
       
    end

    def new
        @travel = Travel.new
        t = @travel.trips.build 
        t.build_location
        # @travel.locations.build   
        # t.trips.build 
    end

    def create
         # binding.pry
         @travel = Travel.new(travel_params)
         if @travel.save 
           redirect_to travels_path
         else
           render :new
         end
    end

    def edit
       
    end

    def update
      
        @travel.update(travel_params)
        if @travel.valid?
          redirect_to travel_path(@travel)
        else
          render :edit
        end
    end

    # def destroy
    #     @travel.destroy 
    #     redirect_to travels_path
    # end

    private
    def travel_params
      params.require(:travel).permit(:name, :address, :trip_id)
    end
      
    def find_travel
      @travel = Travel.find(params[:id])
    end
end
