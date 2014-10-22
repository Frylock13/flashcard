class HomeController < ApplicationController
  def index
    @card = Card.for_review.first
  end

  def check
    @card = Card.find(params[:card_id])
    if @card.check_answer(params[:translated_text])
      flash[:right] = "Верный ответ"
    else
      flash[:wrong] = "Ответ неверный или содержит пустое значение"
    end
    redirect_to root_path
  end
end
