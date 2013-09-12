class Invite < ActiveRecord::Base
  belongs_to :inviter, class_name: "User"
  validates :invitee_email, presence: true
  validates :invitee_name, presence: true

  before_create :generate_token

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end
end
