class Card < ActiveRecord::Base
  before_save :to_lowercase

  has_attached_file :image, styles: { original: "360x360>", thumb: "40x40>" },
                            default_url: "/images/:style/missing.png",
                            storage: :s3,
                            s3_credentials: "#{Rails.root}/config/aws.yml"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, attributes: :image, less_than: 1.megabytes

  validates :origin_text, :translated_text, :user_id, :pack_id, presence: true

  scope :for_review, -> { where('review_date <= ?', Date.today).order("RANDOM()") }
  scope :guesed, -> { where('guesed = ?', true) }
  scope :unguesed, -> { where('guesed = ?', false) }

  belongs_to :user
  belongs_to :pack

  def check_answer(answer)
    if answer.mb_chars.downcase == translated_text and fail_repeat_count < 3
      right_answer
    elsif answer.mb_chars.downcase != translated_text and fail_repeat_count < 2
      wrong_answer
      false
    else
      reset_review_date
      false
    end
  end

  def right_answer
    case successful_repeat_count
      when 0
        update(review_date: Date.today + 24.hours)
      when 1
        update(review_date: Date.today + 3.days)
      when 2
        update(review_date: Date.today + 1.week)
      when 3
        update(review_date: Date.today + 2.weeks)
      when 4
        update(review_date: Date.today + 1.month)
      else
        update(guesed: true)
    end
      update(successful_repeat_count: successful_repeat_count + 1)
  end

  def wrong_answer
    update(fail_repeat_count: fail_repeat_count + 1)
  end

  def reset_review_date
    update(review_date: Date.today + 24.hours, fail_repeat_count: 0)
  end

  def to_lowercase
    self.translated_text = translated_text.mb_chars.downcase
  end
end
