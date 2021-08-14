class Trip < ApplicationRecord
  belongs_to :location
  belongs_to :travel
  accepts_nested_attributes_for :location, reject_if: proc { |attributes| attributes['city'].blank? || attributes['country'].blank?}
  accepts_nested_attributes_for :travel, reject_if: proc { |attributes| attributes['name'].blank? || attributes['address'].blank?}
  validates :budget, numericality: {greater_than: 0, less_than: 15000}

  def location_attributes=(location_hash)
    #byebug
    if !location_hash[:city].blank? && !location_hash[:country].blank?
      self.location = Location.find_or_create_by(location_hash)
    end
  end

  # def travel_attributes=(travel_hash)
  #   if !travel_hash[:name].blank? && !travel_hash[:address].blank?
  #     self.travel =Travel.find_or_create_by(travel_hash)
  #   end
  # end

  def city_and_country
    "#{self.location.city} - #{self.location.country}"
  end

  def self.order_by_price  # custom queries
    # self.order(:budget)
    self.order(budget: :desc).limit(4)
  end
 
  def self.most_expensive
    self.where("budget > 1500")
  end
end
