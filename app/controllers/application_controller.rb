class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def not_authenticated
    redirect_to login_path
    flash[:warning] = "Для использования сервиса, пожалуйста, войдите в систему."
  end

  def check_reg
    if logged_in?
      @card = current_user.cards.for_review.first
    else
      redirect_to about_path
    end
  end
end
