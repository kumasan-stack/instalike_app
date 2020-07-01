class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    # deviseのストロングパラメータ
    def configure_permitted_parameters
      # 新規登録
      devise_parameter_sanitizer.permit(:sign_up,
          keys: [:name, :user_name, :email, :password, :password_confirmation, :provider, :uid])
      # 編集
      devise_parameter_sanitizer.permit(:account_update,
          keys: [:name, :user_name, :email, :phone_number, :sex,
                :site_url, :profile, :password, :password_confirmation])
    end
end
