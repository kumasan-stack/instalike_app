class Users::SessionsController < Devise::SessionsController
  # POST /
  def create
    self.resource = warden.authenticate!(auth_options)
    # flashメッセージの変更
    flash[:success] = "Signed in successfully."
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  # DELETE /logout
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    # flashメッセージの変更
    flash[:success] = "Signed out successfully." if signed_out
    yield if block_given?
    respond_to_on_destroy
  end

  # 認証が失敗した場合に呼び出されるアクション
  def failed
    # wardenで出力されたエラーを保存する
    flash[:danger] = "Invalid Email or password."
    redirect_to root_path
  end

  protected
  def auth_options
    { scope: :user, recall: "users/sessions#failed" }
  end
end
