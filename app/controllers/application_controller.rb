# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # URLの末尾に「?locale=en」をつけると英語化されるようになった。（ページ間のロケールの引き継ぎは未実装、ページを移動するとデフォルトの日本語に戻る）
  around_action :switch_locale

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
end
