class ApplicationController < ActionController::Base
  before_filter :require_login

  protect_from_forgery with: :exception

  def not_authenticated
    redirect_to about_path
    flash[:warning] = "Для использования сервиса, пожалуйста, войдите в систему."
  end
end
