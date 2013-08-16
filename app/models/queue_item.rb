class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  def review_rating
    @review = Review.where(user_id: user_id, video_id: video_id).first
    if @review != nil
      @review.rating
    else
      nil
    end
  end
end
