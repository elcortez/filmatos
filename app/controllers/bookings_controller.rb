class BookingsController < ApplicationController

  def create
    @booking = Booking.new(booking_params)
    @camera = Camera.find(params[:camera_id])
    @booking.camera = @camera
    @user = current_user
    @booking.user = @user
    @booking.status = 'pending'

    if @booking.save
      redirect_to user_path(@user)
    else
      render 'cameras/show'
    end
  end

  def mark_as_accepted
    @booking = Booking.find(params[:id])
    @booking.status = 'accepted'
    @booking.save
    redirect_to user_path(current_user)
  end

  def mark_as_declined
    @booking = Booking.find(params[:id])
    @booking.status = 'declined'
    @booking.save
    redirect_to user_path(current_user)
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
