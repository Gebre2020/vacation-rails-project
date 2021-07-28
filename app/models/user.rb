class User < ApplicationRecord
    has_secure_password  # authenticate, password=, validate
    has_many :locations
end
