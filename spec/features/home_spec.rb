require 'spec_helper'

describe "Homepage" do
  describe "GET /" do
    it "Displays homepage " do
      card = create(:card)
      visit '/'
      page.should have_content("Первый в мире удобный менеджер флеш-карточек.")
      fill_in "translated_text", with: "яблоко"
      click_button "Проверить"
      card.check_answer("яблоко")
      page.should have_content("Верный ответ")
    end
  end
end
