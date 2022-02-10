# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_user, only: [:create]
  
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

    def reject_user
      @user = User.find_by(email: params[:user][:email].downcase)
      # ログイン時に入力されたemailが存在するか探す。
      if @user
        if (@user.valid_password?(params[:user][:password]) && (@user.active_for_authentication? == false))
      # 入力されたパスワードが正しいこと 且つ　active_for_authentication?メソッドがfalseであるかどうか。
          flash[:alert] = "このアカウントは退会済みです。"
          redirect_to new_user_session_path
        end
      else
        flash[:alert] = "必須項目を入力してください"
      end
    end

    # for friendly-forwarding
    def after_sign_in_path_for(resource_or_scope)
      stored_location_for(resource_or_scope) || super
    end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
