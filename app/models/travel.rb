class Travel < ApplicationRecord
    has_many :trips
    has_many :locations, through: :trips

    validates :name, presence: true
    # validation comes from active record method to protct the database
    validates :address, presence: true, uniqueness: true
    #validate :too_many_travel

    def name_and_address
        "#{self.name} - #{self.address}"
    end

    def too_many_travel
        if Travel.all.length >= 4
            errors.add(:base, :invalid, message: "you have too many Travels!")
        end
    end
end
