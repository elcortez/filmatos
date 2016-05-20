class ReviewsController < ApplicationController

  def create
    @camera = Camera.find(params[:camera_id])
    @review = Review.new(review_params)
    @review.camera = @camera

    if @review.save
      redirect_to camera_path(@camera)
    else
      redirect_to camera_path(@camera), :flash => { :alert => "Please, fill in all fields when creating a review." }
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end

end
