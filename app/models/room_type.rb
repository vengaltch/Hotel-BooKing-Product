class RoomType < ActiveRecord::Base
  has_many :room_amenities
  has_many :amenities, through: :room_amenities
  has_many :rooms
end
