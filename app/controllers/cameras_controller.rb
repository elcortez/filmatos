class CamerasController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    if !params[:query_one]
      @cameras = Camera.all
    else
      @cameras = Camera.search(params[:query_one])
    end
    @cameras = @cameras.order('category ASC')
  end
end
