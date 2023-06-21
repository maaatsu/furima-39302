class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:hoge, :hoge_1i, :hoge_2i, :hoge_3i])  # 許可するパラメーターを追加してください
    end
  end