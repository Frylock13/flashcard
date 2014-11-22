require 'spec_helper'

describe Card do
  before :each do
    @pack = create(:pack) # factories/packs.rb
    @card = create(:card) # factories/cards.rb
  end

  it "checks the right answer" do
    expect(@card.check_answer("яблоко")).to be true
  end

  it "checks the right answer uppercase" do
    expect(@card.check_answer("ЯБЛОКО")).to be true
  end

  it "checks date changing if answer is wrong" do
    @card.check_answer("вишня")
    expect(@card.review_date).to eq Date.today
  end

  it "checks change right_repetition_count after first right answer" do
    expect { @card.check_answer("яблоко") }.to change{ @card.right_repetition_count }.from(0).to(1)
  end

  it "checks change review_date after first right answer" do
    @card.check_answer("яблоко")
    expect(@card.review_date).to eq Date.today + 24.hours
  end

  it "checks change review_date after second right answer" do
    @card.right_repetition_count = 1
    @card.check_answer("яблоко")
    expect(@card.review_date).to eq Date.today + 3.days
  end

  it "checks change review_date after third right answer" do
    @card.right_repetition_count = 2
    @card.check_answer("яблоко")
    expect(@card.review_date).to eq Date.today + 1.week
  end

  it "checks change review_date after fourth right answer" do
    @card.right_repetition_count = 3
    @card.check_answer("яблоко")
    expect(@card.review_date).to eq Date.today + 2.weeks
  end

  it "checks change review_date after fifth right answer" do
    @card.right_repetition_count = 4
    @card.check_answer("яблоко")
    expect(@card.review_date).to eq Date.today + 1.month
  end

  it "checks change wrong_repetition_count after wrong answer" do
    expect { @card.check_answer("вишня") }.to change{ @card.wrong_repetition_count }.from(0).to(1)
  end

  it "checks reset counts after three wrong answers" do
    3.times { @card.check_answer("вишня") }
    expect(@card.wrong_repetition_count).to eq 0
  end

  it "checks reset date after three wrong answers" do
    3.times { @card.check_answer("вишня") }
    expect(@card.review_date).to eq Date.today + 24.hours
  end

  it "checks guessed function" do
    @card.right_repetition_count = 5
    @card.check_answer("яблоко")
    expect(@card.guessed).to be true
  end
end
