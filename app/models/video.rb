class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews, -> { order("id DESC")}
  validates :title, presence: true
  validates :description, presence: true

  def self.search_by_title(string)
    if string.blank?
      return []
    else
      where('title LIKE ?', "%#{string}%").order("created_at DESC")
    end
  end

end
