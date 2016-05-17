class CamerasController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    if !params[:query_one]
      @cameras = Camera.all
    else
      @cameras = Camera.search(params[:query_one])
    end
    @cameras = @cameras.order('category ASC')
  end

  def show
    @camera = Camera.find(params[:id])
  end

  def new
    @camera = Camera.new

  end

end
