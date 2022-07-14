# frozen_string_literal: true

class ApplicationController < ActionController::Base

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

end
