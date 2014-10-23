class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy]

  def index
    @cards = Card.all
  end

  def show
  end

  def new
    @card = Card.new
  end

  def edit
  end

  def create
    @card = Card.new(card_params)
    if @card.save
      flash[:access] = "Карточка успешно создана"
    else
      flash[:danger] = "Произошла ошибка при добавлении карточки"
      render 'new'
    end

    redirect_to @card
  end

  def update
    if @card.update(card_params)
      flash[:access] = "Карточка успешно обновлена"
      redirect_to @card
    else
      flash[:danger] = "Произошла ошибка при обновлении карточки"
      render 'edit'
    end
  end

  def destroy
    if @card.destroy
      flash[:access] = "Карточка успешно удалена"
    else
      flash[:danger] = "Произошла ошибка при удалении карточки"
    end

    redirect_to cards_path
  end

  private
    def set_card
      @card = Card.find(params[:id])
    end

    def card_params
      params.require(:card).permit(:origin_text, :translated_text, :review_date)
    end
end
