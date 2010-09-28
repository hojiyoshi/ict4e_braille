class RequestsController < ApplicationController
  def new
    @title = '印刷依頼登録メニュー'
    unless params[:tenji_request].blank?
      @tenji_request = TenjiUser.new(params[:tenji_request])
    else
      tenji_user = current_user.tenji_user
      (zip_code1,zip_code2) = tenji_user.zip_code.split('-') unless tenji_user.zip_code.blank?
      @tenji_request = TenjiRequest.new(
        :from_zip_code1 => zip_code1,
        :from_zip_code2 => zip_code2,
        :from_user_address1 => tenji_user.user_address1,
        :from_user_address2 => tenji_user.user_address2,
        :from_user_address3 => tenji_user.user_address3,
        :from_user_address4 => tenji_user.user_address4,
        :from_user_address5 => tenji_user.user_address5,
        :from_lastname_kanji => tenji_user.lastname_kanji,
        :from_lastname_kana => tenji_user.lastname_kana,
        :from_firstname_kanji => tenji_user.firstname_kanji,
        :from_phone_number1 => tenji_user.phone_number1,
        :from_phone_number2 => tenji_user.phone_number2,
        :from_phone_number3 => tenji_user.phone_number3,
        :from_cellphone_number1 => tenji_user.cellphone_number1,
        :from_cellphone_number2 => tenji_user.cellphone_number2,
        :from_cellphone_number3 => tenji_user.cellphone_number3
      )
    end
    if params[:type].blank?
      respond_to do |format|
        format.html{
          render :action => 'new_index'
        }
      end
    end
  end

  def confirm

  end

  def create
    
  end
end
