class TenjiController < ApplicationController
  def initialize
    @title = 'ホーム'
  end
  def index
    unless current_user.tenji_user
      # 未登録画面を表示する。
      respond_to do |format|
        format.html{
          render :action => 'unregist'
        }
      end
      return
    end
  end

  def license
    @title = '利用許諾'
  end
end
