class ReviewsController < ApplicationController
  before_action :require_user
  def create
    @video = Video.find(params[:video_id])
    @review = @video.reviews.new(params.require(:review).permit(:rating, :content))
    @review.user = current_user

    if @review.save
      flash[:notice] = "Your review was added!"
      redirect_to video_path(@video)
    else
      @failed_review = @video.reviews.reload
      render 'videos/show'
    end
  end
end
