class RoomAmenity < ActiveRecord::Base
  belongs_to :room_type
  belongs_to :amenity
end
