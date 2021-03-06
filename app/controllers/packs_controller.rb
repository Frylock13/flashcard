class PacksController < ApplicationController
  before_action :set_pack, except: [:index, :new, :create, :set_current_pack]

  def index
    @packs = current_user.packs
  end

  def show
    @cards = @pack.cards
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

  private
    def set_pack
      @pack = current_user.packs.find(params[:id])
    end

    def pack_params
      params.require(:pack).permit(:name, :image)
    end
end
