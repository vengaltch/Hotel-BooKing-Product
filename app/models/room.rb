class Room < ActiveRecord::Base
  belongs_to :room_type
  has_many :bookings
  attr_accessor :bulk_upload


  def transform
    hash_map = {
      id: self.id,
      name: self.name,
      type: self.room_type.name,
      cost: self.room_type.cost,
      amenites: self.room_type.amenities
    }
  end
end
