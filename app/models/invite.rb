class Invite < ActiveRecord::Base
  include Tokenable
  belongs_to :inviter, class_name: "User"
  validates :invitee_email, presence: true
  validates :invitee_name, presence: true
end
