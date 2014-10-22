require 'spec_helper'

describe "Homepage" do
  describe "GET /" do
    it "Displays homepage" do
      visit '/'
      expect(page).to have_content "Первый в мире удобный менеджер флеш-карточек."
    end

    it "Check right answer" do
      card = create(:card)
      visit '/'
      fill_in "translated_text", with: "яблоко"
      click_button "Проверить"
      card.check_answer("яблоко")
      expect(page).to have_content "Верный ответ"
    end
  end
end
