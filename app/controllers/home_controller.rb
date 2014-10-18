class HomeController < ApplicationController
  def index
    @card = Card.check_date.order("RANDOM()").first
  end

  def check
    @card = Card.find(params[:id])
    if @card.translated_text == params[:translated_text]
      flash[:notice] = "Верно"
      @card.update(review_date: DateTime.now + 3.days)
    else
      flash[:notice] = "Не верно"
    end
    redirect_to root_path
  end
end
