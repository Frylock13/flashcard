require 'spec_helper'

describe Card do

  it "check the right answer and date" do
    @card = Card.new(origin_text: "apple", translated_text: "яблоко", review_date:DateTime.now.midnight)
    expect(@card.check_answer("яблоко")).to be true
    expect(@card.check_answer("Яблоко")).to be true
    expect(@card.review_date).to eq Date.today + 3.days
    expect(@card.check_answer("2")).to be false
  end

  it "check the wrong answer and date" do
    @card = Card.new(origin_text: "apple", translated_text: "яблоко", review_date:DateTime.now.midnight)
    expect(@card.check_answer("вишня")).to be false
    expect(@card.review_date).to eq Date.today
  end

end
