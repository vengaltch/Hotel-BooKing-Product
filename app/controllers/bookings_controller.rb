class BookingsController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  # GET /bookings
  # GET /bookings.json
  def index

    @bookings = Booking.where(user_id: current_user.id)
    respond_to do |format|
      format.html 
      format.json { render json: @bookings.map{|booking| booking.transform}}
     end
  end

  def create
    #using this if only give give access to users with only api
    if current_user
      user = current_user.id
    else
      user = params[:user]
    end
    #allowing user to book with room number as well from UI
    if params[:room_number]
      params[:room_type] = Room.where(id: params[:room_number]).first.room_type_id
    end
    if params[:start_date] == '' or params[:end_date] == '' or user == '' or params[:room_type] ==''
      render json: {errors: 'need all fields'}, status: 500
    elsif Date.parse(params[:start_date]) >  6.months.from_now
      render json: {error: 'booking not allowed before 6 months'}, status: 500
    else
      rooms = Booking.check_booking_availbility params[:start_date], params[:end_date], params[:room_type]
      if rooms.count > 0
        booking = Booking.create(start_date: params[:start_date], end_date: params[:end_date], room: rooms.first, user_id: user, booking_status_id: 1)
        render json: {message: booking.transform}, status: 200
      else
        render json: {error: 'Rooms are full'}
      end
    end
  end

end
