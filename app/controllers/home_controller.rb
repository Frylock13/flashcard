class HomeController < ApplicationController
  before_action :check_reg, only: [:index]

  def index
  end

  def about
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

  def check_reg
    if logged_in?
      @card = current_user.cards.for_review.first
    else
      redirect_to about_path
    end
  end
end
