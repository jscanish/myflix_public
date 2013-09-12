class User < ActiveRecord::Base
  has_many :queue_items, -> { order(:position) }
  has_many :reviews, -> { order("created_at DESC") }
  validates :full_name, presence: true
  validates :password, presence: true, length: {minimum: 4}
  validates :email, presence: true, uniqueness: true
  has_many :follower_relationships, class_name: "Following", foreign_key: :follower_id
  has_many :followee_relationships, class_name: "Following", foreign_key: :followee_id
  has_many :invites, foreign_key: :inviter_id

  before_create :generate_token
  has_secure_password validations: false

  def reorder_queue_position
    queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(position: index+1)
    end
  end

  def follows?(another_user)
    follower_relationships.map(&:followee).include?(another_user)
  end

  def follow(another_user)
    follower_relationships.create(followee: another_user) if can_follow?(another_user)
  end

  def can_follow?(another_user)
    !(self.follows?(another_user) || self == another_user)
  end

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end

end
