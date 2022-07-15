# frozen_string_literal: true

class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  # authenticate_user!は一番最後に置く必要がある
  before_action :authenticate_user!

  private
  def after_sign_in_path_for(resource)
    # ログイン後に遷移するpathを設定
    # user_path だとidが渡されないためエラーになる
    "/users/#{current_user.id}"
  end



  def after_sign_out_path_for(resource)
    books_path # ログアウト後に遷移するpathを設定
  end

  def configure_permitted_parameters
    added_attrs = [ :email, :username, :password, :password_confirmation ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end

end
