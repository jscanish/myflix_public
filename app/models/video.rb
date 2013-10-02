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
      where('title LIKE ?', "%#{string}%").order("created_at DESC")
    end
  end

end
