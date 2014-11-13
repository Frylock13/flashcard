class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_attached_file :image, styles: { medium: "360x360>", thumb: "40x40>" },
                            default_url: "/assets/:style/missing_avatar.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, attributes: :image, less_than: 1.megabytes

  validates :password, confirmation: true, length: { minimum: 3 }
  validates :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :cards, dependent: :destroy
  has_many :packs, dependent: :destroy

  belongs_to :current_pack, class_name: "Pack"
end
