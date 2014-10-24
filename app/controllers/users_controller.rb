class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  def index
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to cards_path
      flash[:info] = "Поздравляем с регистрацией! Можете добавить свою первую карточку!"
    else
      flash[:danger] = "Произошла ошибка при регистрации, попробуйте еще раз"
      render :new
    end
  end

  def update
    if @user.update(user_params)
      flash[:access] = "Данные успешно обновлены"
      redirect_to cards_path
    else
      flash[:danger] = "Произошла ошибка при обновлении данных"
      render :edit
    end
  end

  private
    def set_user
      if User.find(params[:id]).id  == current_user.id
        @user = User.find(params[:id])
      else
        redirect_to cards_path
        flash[:warning] = "Не надо так делать"
      end
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
