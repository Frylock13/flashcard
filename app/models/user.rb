class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :password, confirmation: true, length: { minimum: 3 }
  validates :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :cards, dependent: :destroy
  has_many :packs, dependent: :destroy

  belongs_to :current_pack, class_name: "Pack"
end
