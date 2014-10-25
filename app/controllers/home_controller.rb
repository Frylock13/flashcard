class HomeController < ApplicationController
  before_action :get_index, only: [:index]

  def index
  end

  def check
    @card = Card.find(params[:card_id])
    if @card.check_answer(params[:translated_text])
      flash[:access] = "Верный ответ"
    else
      flash[:danger] = "Ответ неверный или содержит пустое значение"
    end
    redirect_to root_path
  end

  private
    def get_index
      if logged_in?
        @user = User.find(current_user.id)
        @card = @user.cards.for_review.first
      else
        render 'layouts/index'
      end
    end
end
