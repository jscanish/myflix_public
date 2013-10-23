class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews, -> { order("created_at DESC") }
  has_many :queue_items
  validates :title, presence: true
  validates :description, presence: true


  mount_uploader :large_cover, LargeCoverUploader
  mount_uploader :small_cover, SmallCoverUploader

  def self.search_by_title(string)
    if string.blank?
      return []
    else
      where('LOWER(title) LIKE ?', "%#{string}%").order("created_at DESC")
    end
  end

  def video_rating
    ratings = self.reviews.map { |r| r.rating }
    sum = 0
    ratings.each { |r| sum += r }
    ratings.count == 0 ? "N/A" : (sum.to_f / ratings.count).round(1)
  end
end
