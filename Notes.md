# vacation-rails-project app

User
  - username
  - email
  - password
  - uid
  - provider
  - has_secure_password
  - has_many :locations

Location
  - city
  - country
  - user_id
  - belongs_to :user
  - has_many :trips
  - has_many :travels, through: :trips

Trip
  - location_id
  - travel_id
  - belongs_to :location
  - belongs_to :travel

Travel
  - name
  - address
  - has_many :trips
  - has_many :locations, through: :trips
