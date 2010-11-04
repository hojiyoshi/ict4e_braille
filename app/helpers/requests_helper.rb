module RequestsHelper
  def get_print_type_message
    if params[:type] == 'form'
      return 'テンプレート入力'
    elsif params[:type] == 'upload'
      return 'Wordデータ・点字データ送信'
    end
  end
end
