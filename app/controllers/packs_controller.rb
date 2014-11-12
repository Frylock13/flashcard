class PacksController < ApplicationController
  before_action :set_pack, except: [:index, :new, :create, :reset]

  def index
    @packs = current_user.packs
  end

  def show
    @cards = current_user.cards.where('pack_id = ?', @pack)
  end

  def new
    @pack = Pack.new
  end

  def edit
  end

  def create
    @pack = current_user.packs.new(pack_params)
    if @pack.save
      flash[:access] = "Колода успешно создана"
    else
      flash[:danger] = "Произошла ошибка при добавлении колоды"
    end

    redirect_to packs_path
  end

  def update
    if @pack.update(pack_params)
      flash[:access] = "Колода успешно обновлена"
      redirect_to @pack
    else
      flash[:danger] = "Произошла ошибка при обновлении колоды"
      render 'edit'
    end
  end

  def destroy
    if @pack.destroy
      flash[:access] = "Колода успешно удалена"
    else
      flash[:danger] = "Произошла ошибка при удалении колоды"
    end

    redirect_to packs_path
  end

  def choose_it
    current_user.update_attribute(:pack_id, @pack.id)
    redirect_to packs_path
  end

  def reset
    current_user.update_attribute(:pack_id, nil)
    redirect_to packs_path
  end

  private
    def set_pack
      @pack = current_user.packs.find(params[:id])
    end

    def pack_params
      params.require(:pack).permit(:name, :user_id, :image)
    end
end
