class BookingsController < ApplicationController

  def create
    @booking = Booking.new(booking_params)
    @camera = Camera.find(params[:camera_id])
    @booking.camera = @camera
    @user = current_user
    @booking.user = @user

    if @booking.save
      redirect_to user_path(@user)
    else
      render 'cameras/show'
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
