class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  delegate :category, to: :video
  validates_numericality_of :position, {only_integer: true}

  def review_rating
    @review = Review.where(user_id: user_id, video_id: video_id).first
    @review ? @review.rating : "No Rating"
  end

  def category_name
    category.name
  end
end
