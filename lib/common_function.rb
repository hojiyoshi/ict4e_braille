module CommonFunction
  include ERB::Util
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

  def hbr2(target)
    target = ERB::Util.html_escape(target)
    target.gsub!(/\r\n|\r|\n/, "\n")
    
    result = ''
    target.split("\n").each{|data|
      result += '  ' + data + "\r\n"
    }
    return result
    #target.gsub(/\r\n|\r|\n/, "<br />")
  end
end