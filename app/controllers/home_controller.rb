class HomeController < ApplicationController
  def index
    if logged_in?
      @card = Card.for_review.current_user(current_user.id).first
    else
      render 'layouts/index'
    end
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
end
