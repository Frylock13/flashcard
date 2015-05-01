class Card < ActiveRecord::Base
  before_save :lowercase_translated_text
  before_create :set_default_review_date

  has_attached_file :image, styles: { original: "360x360>", thumb: "40x40>" },
                            default_url: "/images/:style/missing.png",
                            storage: :s3,
                            s3_credentials: "#{Rails.root}/config/secrets.yml"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, attributes: :image, less_than: 1.megabytes

  validates :origin_text, :translated_text, :user_id, :pack_id, presence: true

  scope :for_review, -> { where('review_date <= ?', Date.today).order("RANDOM()") }
  scope :guessed, -> { where(guessed: true) }
  scope :not_guessed, -> { where(guessed: false) }

  belongs_to :user
  belongs_to :pack

  def check_answer(answer)
    if answer.mb_chars.downcase == translated_text && wrong_repetition_count < 3
      set_right_answer
      true
    elsif answer.mb_chars.downcase != translated_text && wrong_repetition_count < 2
      increment_wrong_answers_count
      false
    else
      reset_review_date
      false
    end
  end

  def set_right_answer
    case right_repetition_count
    when 0
      update(review_date: Date.today + 1.day)
    when 1
      update(review_date: Date.today + 3.days)
    when 2
      update(review_date: Date.today + 1.week)
    when 3
      update(review_date: Date.today + 2.weeks)
    when 4
      update(review_date: Date.today + 1.month)
    else
      update(guessed: true)
    end
    increment!(:right_repetition_count, 1)
  end

  def increment_wrong_answers_count
    increment!(:wrong_repetition_count, 1)
  end

  def reset_review_date
    update(review_date: Date.today + 1.day, wrong_repetition_count: 0)
  end

  def lowercase_translated_text
    self.translated_text = translated_text.mb_chars.downcase
  end

  def set_default_review_date
    self.review_date = DateTime.now
  end
end
