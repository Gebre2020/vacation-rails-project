class Travel < ApplicationRecord
    has_many :trips
    has_many :locations, through: :trips
    accepts_nested_attributes_for :locations
    accepts_nested_attributes_for :trips
    validates :name, presence: true
    # validation comes from active record method to protct the database
    validates :address, presence: true, uniqueness: {scope: :name}
    #validate :too_many_travel
    scope :order_by_name, -> {order(:name)}

    def name_and_address
        "#{self.name} - #{self.address}"
    end
    
    # def too_many_travel
    #     if Travel.all.length >= 4
    #         errors.add(:base, :invalid, message: "you have too many Travels!")
    #     end
    # end

     def travel_attributes=(travel_hash)
        if !travel_hash[:name].blank? && !travel_hash[:address].blank?
        self.travel =Travel.find_or_create_by(travel_hash)
        end
    end
end
