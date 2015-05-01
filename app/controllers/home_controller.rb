class HomeController < ApplicationController
  skip_before_filter :require_login, except: [:index]

  def index
    if current_user.current_pack
      @card = current_user.current_pack.cards.for_review.not_guessed.first
    else
      @card = current_user.cards.for_review.not_guessed.first
    end
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
end
