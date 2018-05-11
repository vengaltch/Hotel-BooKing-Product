class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :room
  belongs_to :booking_status

  def transform
    hash_map = {
      id: self.id,
      room: self.room.name,
      room_type: self.room.room_type.name,
      start_date: self.start_date,
      end_date: self.end_date
    }
  end
  def self.check_booking_availbility start_date, end_date, room_type
    # solving fail case when user doesnt select the date 
    if start_date == ''
      start_date = Date.today
    else
      start_date = Date.parse(start_date)
    end
    if end_date == ''
      end_date = start_date + 1.day
    else
      end_date = Date.parse(end_date)    
    end
    rooms = Room.all
    if room_type != ''
      rooms = rooms.rewhere(room_type_id: room_type)
    end
    room_ids = rooms.pluck(:id)
    occupied_count = Booking.where('start_date <= ? and end_date >= ?', start_date, end_date).rewhere(booking_status_id: 1, room_id: room_ids)
    if rooms.count > occupied_count.count
      rooms.where.not(id: occupied_count.pluck(:room_id))
    else
      []
    end
  end
end
