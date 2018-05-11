class SearchController < ApplicationController

  def check_avaiblity
    if params[:start_date] == '' or params[:end_date] == ''
      render json: {errors: 'start_date and end_date are required'}, status: 500
    else
      rooms = Booking.check_booking_availbility(params[:start_date], params[:end_date], params[:room_type])
      render json: rooms.map{|room| room.transform}, status: 200
    end
  end

  def get_room_types
    render json: RoomType.all , status: 200
  end
end
