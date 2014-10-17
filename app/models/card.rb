class Card < ActiveRecord::Base
  validates :origin_text, :translated_text, presence: true
end
