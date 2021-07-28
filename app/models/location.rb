class Location < ApplicationRecord
  belongs_to :user
  has_many :trips
  has_many :travels, through: :trips
end
