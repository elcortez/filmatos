class CamerasController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    load_cameras
    @categories = Camera.categories
    @brands = Camera.brands
  end

  def show
    @camera = Camera.find(params[:id])
  end

  def new
    @camera = Camera.new
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

end
