require 'spec_helper'

describe Card do

  it "check the right answer" do
    @card = Card.new(origin_text: "apple", translated_text: "яблоко")
    expect(@card.check_answer("яблоко")).to be true
  end

  it "check the right answer uppercase" do
    @card = Card.new(origin_text: "apple", translated_text: "яблоко")
    expect(@card.check_answer("ЯБЛОКО")).to be true
  end

  it "check date changing if answer is right" do
    @card = Card.new(origin_text: "apple", translated_text: "яблоко", review_date: DateTime.now.midnight)
    @card.check_answer("яблоко")
    expect(@card.review_date).to eq Date.today + 3.days
  end

  it "check date changing if answer is wrong" do
    @card = Card.new(origin_text: "apple", translated_text: "яблоко", review_date: DateTime.now.midnight)
    @card.check_answer("вишня")
    expect(@card.review_date).to eq Date.today
  end

end
