class CreateRoomTypes < ActiveRecord::Migration
  def change
    create_table :room_types do |t|
      t.string :name, null: false
      t.string :cost, null: false
      t.timestamps null: false
    end
  end
end
