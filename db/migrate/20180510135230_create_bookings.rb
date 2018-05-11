class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.belongs_to :user, index: true
      t.belongs_to :room, index: true
      t.date :start_date
      t.date :end_date
      t.belongs_to :booking_status, index: true
      #not including bill cost as the customer can vacate anytime
      # t.integer :total_cost
      t.timestamps null: false
    end
  end
end
