class Card < ActiveRecord::Base
  before_save :to_lowercase

  validates :origin_text, :translated_text, :user_id, presence: true

  scope :for_review, -> { where('review_date <= ?', Date.today).order("RANDOM()") }

  belongs_to :user

  def self.current_user(id)
    where(user_id: id)
  end

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
