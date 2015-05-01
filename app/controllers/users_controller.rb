class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]

  def new
    @user = User.new
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

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :current_pack_id)
    end
end
