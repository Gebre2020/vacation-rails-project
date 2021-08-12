class TravelsController < ApplicationController

  before_action :redirect_if_not_logged_in

    def index
        @travels = Travel.all
    end

    def show
        @travel = Travel.find_by_id(params[:id])
    end

    def new
        @travel = Travel.new
        t = @travel.trips.build 
        t.build_location
        #@travel.locations.build   
        #t.build_travel  
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
        @travel = Travel.find_by_id(params[:id])
    end

    def update
        @travel = Travel.find_by_id(params[:id])
        @travel.update(travel_params)
        if @travel.valid?
          redirect_to travel_path(@travel)
        else
          render :edit
        end
    end

    # def destroy
    #     @travel = Travel.find_by_id(params[:id])
    #     @travel.destroy 
    #     redirect_to travels_path
    # end

    private
    def travel_params
        params.require(:travel).permit(:name, :address)
    end
        
end
