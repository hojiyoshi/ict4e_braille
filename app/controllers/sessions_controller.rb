# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  skip_before_filter :login_required

  def create
    logout_keeping_session!
    # 認証処理を行う。
    user = User.authenticate(params[:users][:email], params[:users][:password])
    # 認証OKの場合
    if user
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      #
      # Userオブジェクトの値を変数に置く。
      self.current_user = user
      # メールアドレスの初期値をCookieに保存させておく。
      cookies[:user_email] = {:value => params[:users]['email'], :expires => 1.months.from_now}
      # 点字印刷依頼ページにリダイレクトさせる。
      redirect_to :controller => 'requests', :action => 'new', :data_type => params[:users][:data_type]

    # 認証NGの場合
    else
      # NGの時の処理
      note_failed_signin
      # 点字印刷トップページにリダイレクトさせる。
      # たぶん、入力値が保持されない…
      redirect_to :controller => 'tenji'
    end
  end

=begin
  def destroy
    logout_killing_session!
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end
=end
  
protected
  # ログイン失敗時の処理
  def note_failed_signin
    # 失敗時のメッセージをflashに保存しておく。（メッセージの表示させないが、値の有無だけ見ている。）
    flash[:error] = 'メールアドレス、またはパスワードが間違っています。'
    # ログファイルに残しておく。
    logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
end
