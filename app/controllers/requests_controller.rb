class RequestsController < ApplicationController
  # 初期化メソッド（最初に呼ばれる）
  def initialize
    # ページタイトル/ナビゲーションタイトルの設定
    @title = '印刷依頼情報:遠隔点字印刷サービス：みんなのICT'
    # ナビゲーションバーのタイトル（あまりよろしくない。）
    @nav_title = '<a href="/">印刷依頼</a>　＞'
  end
  
  # 依頼登録画面
  # requests/new:GET
  def new
    # 確認画面より、「前画面へ戻る」ボタンをクリックした場合、
    # モデルオブジェクトを作成し、フォームの初期値を入力値とする。
    @tenji_request = TenjiRequest.new(params[:tenji_request])

    # トップページより依頼登録画面へ遷移した場合は、ユーザ情報を発送元の初期値とする。
    if params[:tenji_request].blank?
      # 点字印刷依頼システムのユーザ情報をログインユーザの情報から取得する。
      tenji_user = current_user.tenji_user
      
      unless tenji_user.blank?
        # モデルオブaジェクトに発送元の情報を設定する。
        @tenji_request = TenjiRequest.new(
          :from_zip_code        => tenji_user.zip_code,
          :from_user_address1   => tenji_user.user_address1,
          :from_user_address2   => tenji_user.user_address2,
          :from_user_name  => tenji_user.user_name,
          :from_user_affiliation   => tenji_user.user_affiliation,
          :from_phone_number   => tenji_user.phone_number
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
    @tenji_request.user_id = current_user.id

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
    @tenji_request.user_id = current_user.id
    # データベースに登録する。
    if @tenji_request.save
      # メールを送る。
      RequestMail.deliver_request_mail(@tenji_request)

      #
      if @tenji_request.data_type == 'data_type_text'
        file_name = RAILS_ROOT + "/public/download/#{@tenji_request.braille_datafile}"
        ## XMLファイルを出力する。
        @tenji_request.braille_datafile = Time.now.strftime("%Y%m%d%H%M%S") + '.txt'
        
        source = <<EOF
<h1>#{@tenji_request.print_title1}</h1>
<p>#{@tenji_request.print_contents1}</p>

<h1>#{@tenji_request.print_title2}</h1>
<p>#{@tenji_request.print_contents1}</p>

<h1>#{@tenji_request.print_title3}</h1>
<p>#{@tenji_request.print_contents1}</p>
EOF

        foo = File.open(file_name,'w')
        foo.puts source
        foo.close
    end
    
    # 「入力した名前・住所等を登録する」チェックがされている場合
    if params[:entry]['entry'] == '1'
      #
      user = @tenji_request.user
      if user.tenji_user.blank?
        # 関連性よりTenjiUserオブジェクトを作成する。
        user.build_tenji_user
      end
      # 依頼人の情報を点字印刷ユーザオブジェクトに代入する。
      user.tenji_user.zip_code = @tenji_request.from_zip_code
      user.tenji_user.user_name = @tenji_request.from_user_name
      user.tenji_user.user_affiliation = @tenji_request.from_user_affiliation
      user.tenji_user.phone_number = @tenji_request.from_phone_number
      user.tenji_user.user_address1 = @tenji_request.from_user_address1
      user.tenji_user.user_address2 = @tenji_request.from_user_address2
      # 点字印刷ユーザオブジェクトを保存する。
      user.tenji_user.save
    end
  end
end
