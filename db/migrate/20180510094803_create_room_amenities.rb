class CreateRoomAmenities < ActiveRecord::Migration
  def change
    create_table :room_amenities do |t|
      t.belongs_to :room_type, index: true
      t.belongs_to :amenity, index: true
      t.timestamps null: false
    end
  end
end
