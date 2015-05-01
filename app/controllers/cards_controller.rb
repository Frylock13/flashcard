class CardsController < ApplicationController
  before_action :set_card, except: [:index, :new, :create, :guessed]

  def index
    @cards = current_user.cards.not_guessed
  end

  def show
  end

  def new
    @card = Card.new
  end

  def edit
  end

  def create
    @card = current_user.cards.new(card_params)
    if @card.save
      flash[:access] = "Карточка успешно создана"
    else
      flash[:danger] = "Произошла ошибка при добавлении карточки"
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

  def guessed
    @cards = current_user.cards.guessed
  end

  private
    def set_card
      @card = current_user.cards.find(params[:id])
    end

    def card_params
      params.require(:card).permit(:origin_text, :translated_text, :pack_id, :image)
    end
end
