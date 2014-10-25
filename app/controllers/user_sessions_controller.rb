class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password], params[:remember_me])
      flash[:access] = "Вы успешно вошли!"
      redirect_to cards_path
    else
      flash.now[:danger] = "Не удалось войти, проверьте email и пароль."
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path
    flash[:info] = "До новых встреч!"
  end
end
