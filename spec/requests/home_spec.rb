require 'spec_helper'

describe "homepage" do
  before :each do
    login
    card = create(:card)
    visit root_path
  end

  describe "GET /" do
    it "displays homepage" do
      expect(page).to have_content "Первый в мире удобный менеджер флеш-карточек."
    end

    it "checks right answer" do
      fill_in "translated_text", with: "яблоко"
      click_button "Проверить"
      expect(page).to have_content "Верный ответ"
    end

    it "checks wrong answer" do
      fill_in "translated_text", with: "вишня"
      click_button "Проверить"
      expect(page).to have_content "Ответ неверный или содержит пустое значение"
    end
  end
end
