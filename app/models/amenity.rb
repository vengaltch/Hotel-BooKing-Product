class Amenity < ActiveRecord::Base
  has_many :room_types, through: :room_amenities
  has_many :room_amenities
end
