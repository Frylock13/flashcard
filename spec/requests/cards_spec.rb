require 'spec_helper'

describe "cards page" do
  before :each do
    login
    card = create(:card)
    visit cards_path
  end

  describe "GET /cards" do
    it "displays page" do
      expect(page).to have_content "Флэшкарточкер"
    end

    it "checks new button" do
      page.find("#new_card").click
      expect(page).to have_content "Новая карточка"
    end

    it "checks edit button" do
      page.find("#edit_card").click
      expect(page).to have_content "Редактировать карточку"
    end

    it "checks delete button" do
      page.find("#delete_card").click
      expect(page).to have_content "Карточка успешно удалена"
    end
  end
end
