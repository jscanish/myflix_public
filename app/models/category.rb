class Category < ActiveRecord::Base
  has_many :videos
  validates :name, presence: true

  def recent_videos
    videos.last(6).reverse
  end
end
