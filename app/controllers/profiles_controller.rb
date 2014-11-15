class ProfilesController < ApplicationController

  def show
  end

  def edit
  end

  def update
    if current_user.update(profile_params)
      flash[:access] = "Данные успешно обновлены"
      redirect_to profile_path
    else
      flash[:danger] = "Произошла ошибка при обновлении данных"
      render :edit
    end
  end

  def set_current_pack
    current_user.update_attribute(:current_pack_id, params[:pack_id])
    redirect_to packs_path
  end

  def reset_current_pack
    current_user.update_attribute(:current_pack_id, nil)
    redirect_to packs_path
  end

  private
    def profile_params
      params.require(:user).permit(:email, :password, :password_confirmation, :current_pack_id, :image)
    end
end
