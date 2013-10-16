class VideoDecorator < Draper::Decorator
  delegate_all

  def video_rating
    ratings = object.reviews.map { |r| r.rating }
    sum = 0
    ratings.each { |r| sum += r }
    ratings.count == 0 ? "N/A" : sum / ratings.count
  end
end
