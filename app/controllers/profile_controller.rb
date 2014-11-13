class ProfileController < ApplicationController
  before_action :set_profile

  def show
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      flash[:access] = "Данные успешно обновлены"
      redirect_to cards_path
    else
      flash[:danger] = "Произошла ошибка при обновлении данных"
      render :edit
    end
  end

  def reset_current_pack
    @profile.update_attribute(:current_pack_id, nil)
    redirect_to packs_path
  end

  private
    def set_profile
      @profile = current_user
    end

    def profile_params
      params.require(:user).permit(:email, :password, :password_confirmation, :current_pack_id, :image)
    end
  end
