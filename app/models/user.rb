class User < ActiveRecord::Base
has_many  :reviews
validates :full_name, presence: true
validates :password, presence: true, length: {minimum: 4}
validates :email, presence: true, uniqueness: true

has_secure_password validations: false

end
