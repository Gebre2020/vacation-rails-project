module TripsHelper 
    
    def trip_price
        if @trip.budget > 1500 
            content_tag(:h6, "Trip Budget: #{number_to_currency(@trip.budget)}")
           
        else
            content_tag(:h1, "Trip Budget: #{number_to_currency(@trip.budget)}") 
            # <h1>Trip Budget Amount:-  number_to_currency(@trip.budget) </h1>
        end 
    end

    def index_header_location
         if @location
            content_tag(:h1, "A Location: '#{@location.city} - #{@location.country}'")
         else
            content_tag(:h1, "All the Trips!!")
         end
    end

    def form_header_location
        if @location
           content_tag(:h1, "Create Location: '#{@location.city} - #{@location.country}' ")
        else
           content_tag(:h1, "Create Trip!")
        end
    end

    def location_field_helper(f)
        if @location 
          f.hidden_field :location_id, value: @location.id 
        else 
          render partial: "build_location", locals: {f: f} 
        end 
    end

end
