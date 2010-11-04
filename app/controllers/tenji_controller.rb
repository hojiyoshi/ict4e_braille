class TenjiController < ApplicationController
  skip_before_filter :login_required

  # 印刷依頼のルート画面
  # /:[GET]
  def index
    # タイトルの設定
    @title = '印刷依頼：みんなのICT'
    # Cookieからメールアドレスの初期値を読み込む
    @user_email = cookies[:user_email]
  end

end
