# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # POST /
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  # 認証が失敗した場合に呼び出されるアクション
  def failed
    # wardenで出力されたエラーを保存する
    flash[:notice] = flash[:notice].to_a.concat [flash[:alert]]
    redirect_to root_path
  end

  protected
  def auth_options
    { scope: :user, recall: "users/sessions#failed" }
  end
end
