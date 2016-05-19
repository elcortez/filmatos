class CamerasController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  layout "map", only: [:index]

  def index
    load_cameras
    @users = User.near(params[:location], 5)
    @near_cameras = []
    @cameras.each do |camera|
      @near_cameras << camera if @users.include?(camera.user)
    end
    @categories = Camera.categories
    @brands = Camera.brands

    # Let's DYNAMICALLY build the markers for the view.
    @markers = Gmaps4rails.build_markers(@near_cameras) do |camera, marker|
      marker.lat camera.user.latitude
      marker.lng camera.user.longitude
    end
  end

  def show
    @camera = Camera.find(params[:id])
    @booking = Booking.new
  end

  def new
    @user = User.find(params[:user_id])
    @camera = Camera.new
    @brands = Camera.brands
    @categories = Camera.categories
  end

  def create
    @camera = Camera.new(camera_params)
    @user = User.find(params[:user_id])
    @camera.user = current_user
    @camera.save
    redirect_to cameras_path
  end

  def destroy
    @camera = Camera.find(params[:id])
    @camera.destroy
    @user = current_user
    redirect_to user_path(@user)
  end

  private

  def load_cameras
    params[:category] ||= []
    params[:brand] ||= []

    @cameras = Camera.where(nil)
      @cameras = @cameras.search_with_description(params[:description]) if params[:description].present?
      @cameras = @cameras.search_with_brand(params[:brand]) if params[:brand].present?
      @cameras = @cameras.search_with_category(params[:category]) if params[:category].present?
      @cameras = @cameras.search_with_price(params[:price_min], params[:price_max]) if params[:price_min].present? && params[:price_max].present?
      @cameras = @cameras.search_with_price(params[:price_min], 10**10) if params[:price_min].present? && params[:price_max].blank?
      @cameras = @cameras.search_with_price(0, params[:price_max]) if params[:price_min].blank? && params[:price_max].present?
      @cameras = @cameras.search_with_price(0, 10**10) if params[:price_min].blank? && params[:price_max].blank?
      @cameras = @cameras.order('category ASC')
    @cameras.all
  end

  def camera_params
    params.require(:camera).permit(:brand, :category, :description, :price, :photo)
  end


end
