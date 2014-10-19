class Card < ActiveRecord::Base
  validates :origin_text, :translated_text, presence: true

  scope :for_review, -> { where('review_date <= ?', DateTime.now).order("RANDOM()") }

  def check_answer(answer)
    if answer == translated_text
      change_review_date
    else
      false
    end
  end

  def change_review_date
    update(review_date: DateTime.now + 3.days)
  end
end
