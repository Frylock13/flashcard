class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :password, confirmation: true, length: { minimum: 3 }
  validates :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :cards, dependent: :destroy
end
