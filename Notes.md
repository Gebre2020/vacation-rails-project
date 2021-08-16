# vacation-rails-project app
Make a folder and files for a User, Location, Trip, Travel models by using rails g resource
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

- After set up the models and the tables, run rake db:migrate
  =>then, go to the rails console to check the models associtions relationship
- Include a many-to-many relationship implemented with has_many :through associations
- writing  validations for attributes
- writing a scope method like .where and .order
- the application have user authentication, signup, login, logout, and passwords.
- login with google
- writing a nested resource with the appropriate RESTful URLs.
- creating nested routing and form
- creating a views with a validation errors
- using layouts,partials,and helper to make the app DRY
  