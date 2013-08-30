class User < ActiveRecord::Base
  has_many :queue_items, -> { order(:position) }
  has_many :reviews, -> { order("created_at DESC") }
  validates :full_name, presence: true
  validates :password, presence: true, length: {minimum: 4}
  validates :email, presence: true, uniqueness: true

  has_secure_password validations: false

  def reorder_queue_position
    queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(position: index+1)
    end
  end
end
