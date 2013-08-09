class Video < ActiveRecord::Base
  belongs_to :category
  validates :title, presence: true
  validates :description, presence: true

  def self.search_by_title(string)
    if string.blank?
      return []
    else
      where('title LIKE ?', "%#{string}%")
    end
  end

end
