class Location < ApplicationRecord
  belongs_to :user
  has_many :trips
  has_many :travels, through: :trips
  accepts_nested_attributes_for :trips,:travels, reject_if: proc { |attributes| attributes['city'].blank? || attributes['country'].blank?}
 
  
  validates :city, presence: true, length: {minimum: 2, message: "has to be longer than 2!!!"}
  validates :country, presence: true
  
  def travels_attributes=(attributes)
    attributes.values.each do |v|
      self.travels << Travel.find_or_create_by(v) if !v['name']
    end
  end

  def trips_attributes=(trip_hash)
    if !trip_hash[:budget].blank? 
      self.trip =Trip.find_or_create_by(trip_hash)
    end
  end
  #alphabetize the list of locations
  #scope :alpha, -> {'city'}
  # scope :alpha, -> {order(:city)}


  def city_and_country
    "#{self.city} - #{self.country}"
  end
end
