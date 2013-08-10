class Category < ActiveRecord::Base
  has_many :videos

  def recent_videos
    self.videos.last(6).reverse
  end
end
