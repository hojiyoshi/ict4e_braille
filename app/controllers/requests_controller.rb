class RequestsController < ApplicationController
  # 初期化メソッド（最初に呼ばれる）
  def initialize
    # ページタイトル/ナビゲーションタイトルの設定
    @title = '印刷依頼の登録'
  end
  # 依頼登録画面
  # requests/new:GET
  def new
    # 確認画面より、「前画面へ戻る」ボタンをクリックした場合、
    # モデルオブジェクトを作成し、フォームの初期値を入力値とする。
    unless params[:tenji_request].blank?
      @tenji_request = TenjiRequest.new(params[:tenji_request])
    # トップページより依頼登録画面へ遷移した場合は、ユーザ情報を発送元の初期値とする。
    else
      # 点字印刷依頼システムのユーザ情報をログインユーザの情報から取得する。
      tenji_user = current_user.tenji_user
      unless tenji_user.blank?
        # モデルオブジェクトに発送元の情報を設定する。
        @tenji_request = TenjiRequest.new(
          :from_zip_code        => tenji_user.zip_code,
          :from_user_address1   => tenji_user.user_address1,
          :from_user_address2   => tenji_user.user_address2,
          :from_lastname_kanji  => tenji_user.user_name,
          :from_lastname_kana   => tenji_user.user_affiliation,
          :from_phone_number1   => tenji_user.phone_number
        )
      end
    end
  end

  # 印刷依頼確認画面
  # requests/confirm:PUTS
  def confirm
    @tenji_request = TenjiRequest.new(params[:tenji_request])
    # 「依頼人に送る」チェックがある場合は、発送先に依頼人の情報を代入する。
    # とりあえず、ベタに代入。なんかいまいちなコード･･･
    if params[:tenji_request]['to_type'] == 'to_type_same'
      @tenji_request.to_zip_code = @tenji_request.from_zip_code
      @tenji_request.to_user_name = @tenji_request.from_user_name
      @tenji_request.to_user_address1 = @tenji_request.from_user_address1
      @tenji_request.to_user_address2 = @tenji_request.from_user_address2
    end

    # 値検証NGの場合は、登録画面を表示する。
    unless @tenji_request.valid?
      respond_to do |format|
        format.html{
          render :action => 'new'
        }
      end
    end
  end

  def create
    @tenji_request = TenjiRequest.new(params[:tenji_request])
    @tenji_request.req_id = current_user.tenji_user.id
    # データベースに登録する。
    if @tenji_request.save
      # メールを送る。
    end
    # 「入力した名前・住所等を登録する」チェックがされている場合
    if params[:tenji_request]['entry']

    end
  end
end
