class Trip < ApplicationRecord
  belongs_to :location
  belongs_to :travel
end
