class Card < ActiveRecord::Base
  validates :origin_text, :translated_text, presence: true

  scope :check_date, -> { where('review_date <= ?', DateTime.now) }
end
