require 'spec_helper'

describe "packs_page" do
  before :each do
    login
    pack = create(:pack, user_id: 1, name: "Фрукты")
    visit packs_path
  end

  describe 'GET /packs' do
    it "displays page" do
      expect(page).to have_content "Фрукты"
    end

    it "checks new button" do
      page.find("#new_pack").click
      expect(page).to have_content "Новая колода"
    end

    it "checks edit button" do
      page.find("#edit_pack").click
      expect(page).to have_content "Редактировать колоду"
    end

    it "checks delete button" do
      page.find("#delete_pack").click
      expect(page).to have_content "Колода успешно удалена"
    end
  end
end
