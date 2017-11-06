class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, only: [:approve, :decline]

  def create
    room = Room.find_by id: params[:room_id]

    if current_user == room.user
      flash[:alert] = t ".you_cannot_book_your_own_property"
    else
      start_date = Date.parse(reservation_params[:start_date])
      end_date = Date.parse(reservation_params[:end_date])
      reservation = Reservation.where('room_id = ? AND ((start_date <= ? AND end_date >= ?) OR (start_date <= ? AND end_date >= ?))',
                                      params[:room_id], start_date, start_date, end_date, end_date)
      if reservation.present?
        flash[:alert] = "This room not available in this time."
      else
        days = (end_date - start_date).to_i + 1

        @reservation = current_user.reservations.build(reservation_params)
        @reservation.room = room
        @reservation.price = room.price
        @reservation.total = room.price * days

        if @reservation.save
          if room.Request?
            flash[:notice] = t ".request_sent_successfully"
          else
            @reservation.Approved!
            flash[:notice] = t ".reservation_created_successfully"
          end
        else
          flash[:alert] = t ".cannot_make_a_reservation"
        end
      end
    end
    redirect_to room
  end

  def your_trips
    @trips = current_user.reservations.order(start_date: :asc)
  end

  def your_reservations
    @rooms = current_user.rooms
  end

  def approve
    @reservation.Approved!
    redirect_to your_reservations_path
  end

  def decline
    @reservation.Declined!
    redirect_to your_reservations_path
  end

  private
  def set_reservation
    @reservation = Reservation.find_by id: params[:id]
  end

  def reservation_params
    # Dont put id, price
    params.require(:reservation).permit(:start_date, :end_date)
  end
end
