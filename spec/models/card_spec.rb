require 'spec_helper'

describe Card do
  before :each do
    @card = create(:card)
  end

  it "check the right answer" do
    expect(@card.check_answer("яблоко")).to be true
  end

  it "check the right answer uppercase" do
    expect(@card.check_answer("ЯБЛОКО")).to be true
  end

  it "check date changing if answer is right" do
    @card.check_answer("яблоко")
    expect(@card.review_date).to eq Date.today + 3.days
  end

  it "check date changing if answer is wrong" do
    @card.check_answer("вишня")
    expect(@card.review_date).to eq Date.today
  end
end
