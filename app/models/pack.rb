class Pack < ActiveRecord::Base

  has_attached_file :image, styles: { original: "360x360>", thumb: "40x40>" },
                            default_url: "/images/:style/missing.png",
                            s3_credentials: "#{Rails.root}/config/aws.yml" #Amazon S3
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, attributes: :image, less_than: 1.megabytes

  validates :name, presence: true

  has_many :cards, dependent: :destroy

end
