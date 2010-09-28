module CommonFunction
  def get_flash_messages(messages,type)
    render_to_string :partial => 'layouts/messages',
      :locals => {:messages => messages, :type => type}
  end

  # 多重サブミットをチェックするメソッド
  def double_submit
    if double_submit?
      redirect_to :controller => 'home', :action => 'double_submit'
    end
  end
end