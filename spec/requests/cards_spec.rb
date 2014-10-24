require 'spec_helper'

describe "cards page" do
  describe "GET /cards" do
    it "displays page" do
      visit cards_path
      expect(page).to have_content "Флэшкарточкер"
    end

    it "checks new button" do
      visit cards_path
      page.find("#new_card").click
      expect(page).to have_content "Новая карточка"
    end

    it "checks edit button" do
      create(:card)
      visit cards_path
      page.find("#edit_card").click
      expect(page).to have_content "Редактировать карточку"
    end

    it "checks delete button" do
      create(:card)
      visit cards_path
      page.find("#delete_card").click
      expect(page).to have_content "Карточка успешно удалена"
    end
  end
end
