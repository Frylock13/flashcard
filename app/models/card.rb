class Card < ActiveRecord::Base
  before_save :to_lowercase

  has_attached_file :image, styles: { original: "360x360>", thumb: "40x40>" },
                            default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, attributes: :image, less_than: 1.megabytes

  validates :origin_text, :translated_text, :user_id, :pack_id, presence: true

  scope :for_review, -> { where('review_date <= ?', Date.today).order("RANDOM()") }
  scope :not_review, -> { where('review_date > ?', Date.today).order("RANDOM()") }

  belongs_to :user
  belongs_to :pack

  def check_answer(answer)
    if answer.mb_chars.downcase == translated_text
      change_review_date
    else
      false
    end
  end

  def change_review_date
    update(review_date: Date.today + 3.days)
  end

  def to_lowercase
    self.translated_text = translated_text.mb_chars.downcase
  end
end
