require 'spec_helper'

describe CardsController do
  describe "index action" do
    it "renders index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "show action" do
    it "renders show template" do
      card = create(:card)
      get :show, id: card.id
      expect(response).to render_template('show')
    end
  end

  describe "new action" do
    it "renders new template" do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe "edit action" do
    it "renders edit template" do
      card = create(:card)
      get :edit, id: card.id
      expect(response).to render_template('edit')
    end
  end

  describe "create action" do
    subject { post :create, card: { origin_text: "apple", translated_text: "яблоко", review_date: Date.today} }

    it "checks redirect after create card" do
      expect(subject).to redirect_to(assigns(:card))
    end
  end

  describe "update action" do
    it "checks update method" do
      card = create(:card) #origin_text: apple
      put :update, id: card.id, origin_text: "cherry", card: attributes_for(:card, origin_text: "cherry")
      card.reload
      expect(card.origin_text).to eq("cherry")
    end
  end

  describe "destroy action" do
    it "redirects to index action when card is deleted" do
      card = create(:card)
      delete :destroy, id: card.id
      expect(response).to redirect_to(cards_path)
    end
  end
end
