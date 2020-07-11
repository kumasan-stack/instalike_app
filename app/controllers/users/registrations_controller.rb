class Users::RegistrationsController < Devise::RegistrationsController
  before_action :store_location, only: [:edit] 
  
  # GET /users/signup
  def new
    super
  end
  
  # POST /users
  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        # flashメッセージを変更
        flash[:success] = "Welcome to Instagram."
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :danger, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  # GET /users/edit
  def edit
    super
  end

  # PATCH /users
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      # flashメッセージを変更
      flash[:success] = "Your account has been updated successfully."
      bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?
      # リダイレクト (or レンダー)先を変更
      respond_with resource, location: user_path(current_user)
    else
      clean_up_passwords resource
      set_minimum_password_length
      render :edit
    end
    session.delete(:forwarding_path)
  end

  # DELETE /resource
  def destroy
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    # flashメッセージの変更
    set_flash_message! :success, :destroyed
    yield resource if block_given?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end

  protected
    # プロフィール編集では現在のパスワードを求めない(パスワード変更を除く)
    def update_resource(resource, params)
      if params.has_key?(:password)
        super
      else
        resource.update_without_current_password(params)
      end
    end

    def after_sign_up_path_for(resource)
      user_path(current_user)
    end
end

private

  # 編集時のURLを覚えておく(プロフィール編集かパスワード編集か)
  def store_location
    session[:forwarding_path] = request.path_info
  end